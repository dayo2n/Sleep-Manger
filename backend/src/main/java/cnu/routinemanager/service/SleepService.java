package cnu.routinemanager.service;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.domain.Member;
import cnu.routinemanager.domain.Sleep;
import cnu.routinemanager.dto.request.DaySleepRecordRequest;
import cnu.routinemanager.dto.response.DaySleepRecordResponse;
import cnu.routinemanager.exception.SleepException;
import cnu.routinemanager.repository.SleepRepository;

@Service
public class SleepService {
    private final MemberService memberService;
    private final SleepRepository sleepRepository;

    public SleepService(MemberService memberService, SleepRepository sleepRepository) {
        this.memberService = memberService;
        this.sleepRepository = sleepRepository;
    }

    @Transactional
    public void createDaySleepRecord(DaySleepRecordRequest daySleepRecordRequest) {
        Member member = memberService.findById(daySleepRecordRequest.getId());
        boolean isDaySleepRecordAlreadyExists = sleepRepository.existsByMemberIdAndDate(daySleepRecordRequest.getId(), daySleepRecordRequest
                .getDate());

        if (isDaySleepRecordAlreadyExists) {
            throw new SleepException("해당 날짜의 수면 기록이 이미 존재합니다.", HttpStatus.BAD_REQUEST);
        }

        Sleep sleep = new Sleep(
                member,
                daySleepRecordRequest.getBedTime(),
                daySleepRecordRequest.getWakeUpTime(),
                daySleepRecordRequest.getDate()
        );
        sleepRepository.save(sleep);
    }

    public DaySleepRecordResponse findDaySleepRecord(Long memberId, LocalDate date) {
        Sleep sleep = sleepRepository.findByMemberIdAndDate(memberId, date)
                                     .orElseThrow(() -> new SleepException("해당 날짜의 수면 기록이 존재하지 않습니다.", HttpStatus.NOT_FOUND));
        return new DaySleepRecordResponse(date, sleep.getBedTime(), sleep.getWakeUpTime());
    }

    public List<DaySleepRecordResponse> findPeriodSleepRecord(Long memberId, LocalDate startDate, int offset) {
        LocalDate endDate = startDate.plusDays(offset);
        List<Sleep> sleeps = sleepRepository.findByMemberIdAndDateBetween(memberId, startDate, endDate);

        sleeps.sort(Comparator.comparing(Sleep::getDate));

        return sleeps.stream()
                     .map(sleep -> new DaySleepRecordResponse(sleep.getDate(), sleep.getBedTime(), sleep.getWakeUpTime()))
                     .collect(Collectors.toList());
    }
}

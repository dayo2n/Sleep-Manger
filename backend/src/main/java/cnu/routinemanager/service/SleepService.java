package cnu.routinemanager.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.domain.Member;
import cnu.routinemanager.domain.Sleep;
import cnu.routinemanager.dto.request.DaySleepRecordRequest;
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
            throw new SleepException("해당 날짜의 수면 기록이 이미 존재합니다.");
        }

        Sleep sleep = new Sleep(
                member,
                daySleepRecordRequest.getBedTime(),
                daySleepRecordRequest.getWakeUpTime(),
                daySleepRecordRequest.getDate()
        );
        sleepRepository.save(sleep);
    }
}

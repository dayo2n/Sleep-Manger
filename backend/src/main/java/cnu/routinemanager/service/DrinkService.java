package cnu.routinemanager.service;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.domain.Drink;
import cnu.routinemanager.domain.Member;
import cnu.routinemanager.dto.request.DrinkRecordRequest;
import cnu.routinemanager.dto.response.DrinkRecordResponse;
import cnu.routinemanager.exception.SleepException;
import cnu.routinemanager.repository.DrinkRepository;

@Service
public class DrinkService {
    private final MemberService memberService;
    private final DrinkRepository drinkRepository;

    public DrinkService(MemberService memberService, DrinkRepository drinkRepository) {
        this.memberService = memberService;
        this.drinkRepository = drinkRepository;
    }

    @Transactional
    public void createDrinkRecord(DrinkRecordRequest drinkRecordRequest) {
        Member member = memberService.findById((drinkRecordRequest.getId()));
        boolean isDrinkRecordAlreadyExists = drinkRepository.existsByMemberIdAndDate(drinkRecordRequest.getId(), drinkRecordRequest
                .getDate());

        //if(isDrinkRecordAlreadyExists){
        //    throw new
        //}

        Drink drinkRecord = new Drink(member,
                drinkRecordRequest.getAmount(),
                drinkRecordRequest.getDate());
        drinkRepository.save(drinkRecord);
    }

    public DrinkRecordResponse findDrinkRecord(Long memberId, LocalDate date) {
        Drink drinkRecord = drinkRepository.findByMemberIdAndDate(memberId, date)
                                           .orElseThrow(() -> new SleepException("해당 날짜의 수분 섭취 기록이 존재하지 않습니다.", HttpStatus.NOT_FOUND));
        //exception 만들어야함
        return new DrinkRecordResponse(date, drinkRecord.getAmount());
    }

    public List<DrinkRecordResponse> findDrinkRecord(Long memberId, LocalDate startDate, int offset) {
        LocalDate endDate = startDate.plusDays(offset);
        List<Drink> drinkRecords = drinkRepository.findByMemberIdAndDateBetween(memberId, startDate, endDate);
        drinkRecords.sort(Comparator.comparing(Drink::getDate));
        return drinkRecords.stream()
                           .map(drinkRecord -> new DrinkRecordResponse(drinkRecord.getDate(), drinkRecord.getAmount()))
                           .collect(Collectors.toList());
    }
}

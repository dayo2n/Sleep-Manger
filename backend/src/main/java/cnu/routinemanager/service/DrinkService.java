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
import cnu.routinemanager.exception.DrinkException;
import cnu.routinemanager.repository.DrinkRepository;

@Service
public class DrinkService {
    private static final boolean CREATED = true;
    private static final boolean UPDATED = false;

    private final MemberService memberService;
    private final DrinkRepository drinkRepository;

    public DrinkService(MemberService memberService, DrinkRepository drinkRepository) {
        this.memberService = memberService;
        this.drinkRepository = drinkRepository;
    }

    // 사용자가 수분 섭취를 기록하면, 수분 섭취 기록을 생성 및 업데이트
    @Transactional
    public boolean createOrUpdateDrinkRecord(DrinkRecordRequest drinkRecordRequest) {
        Member member = memberService.findById((drinkRecordRequest.getId()));

        Drink drink = new Drink(
                member,
                drinkRecordRequest.getAmount(),
                drinkRecordRequest.getDate()
        );

        if (member.hasDrinkRecordOn(drinkRecordRequest.getDate())) {
            member.addDrinkAmount(drinkRecordRequest.getDate(), drinkRecordRequest.getAmount());
            return UPDATED;
        } else {
            drinkRepository.save(drink);
            return CREATED;
        }
    }

    // 수분 섭취 기록을 수정
    @Transactional
    public void modifyDrinkRecord(DrinkRecordRequest drinkRecordRequest) {
        Member member = memberService.findById(drinkRecordRequest.getId());
        member.modifyDrinkAmount(drinkRecordRequest.getDate(), drinkRecordRequest.getAmount());
    }

    // 수분 섭취 기록을 데이터베이스에서 찾아오기 (1일)
    public DrinkRecordResponse findDrinkRecord(Long memberId, LocalDate date) {
        Drink drinkRecord = drinkRepository.findByMemberIdAndDate(memberId, date)
                                           .orElseThrow(() -> new DrinkException("해당 날짜의 수분 섭취 기록이 존재하지 않습니다.", HttpStatus.NOT_FOUND));

        return new DrinkRecordResponse(date, drinkRecord.getAmount());
    }

    // 수분 섭취 기록을 데이터베이스에서 찾아오기 (특정 기간)
    public List<DrinkRecordResponse> findDrinkRecord(Long memberId, LocalDate startDate, int offset) {
        LocalDate endDate = startDate.plusDays(offset);
        List<Drink> drinkRecords = drinkRepository.findByMemberIdAndDateBetweenOrderByDate(memberId, startDate, endDate);
        return drinkRecords.stream()
                           .map(drinkRecord -> new DrinkRecordResponse(drinkRecord.getDate(), drinkRecord.getAmount()))
                           .collect(Collectors.toList());
    }
}

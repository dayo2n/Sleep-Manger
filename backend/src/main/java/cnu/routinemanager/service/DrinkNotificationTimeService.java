package cnu.routinemanager.service;

import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.EntityNotFoundException;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cnu.routinemanager.domain.DrinkNotificationTime;
import cnu.routinemanager.domain.Member;
import cnu.routinemanager.dto.request.DrinkNotificationTimeRequest;
import cnu.routinemanager.dto.response.DrinkNotificationTimeResponse;
import cnu.routinemanager.exception.DrinkException;
import cnu.routinemanager.repository.DrinkNotificationTimeRepository;

@Service
public class DrinkNotificationTimeService {
    private final MemberService memberService;
    private final DrinkNotificationTimeRepository drinkNotificationTimeRepository;

    public DrinkNotificationTimeService(MemberService memberService, DrinkNotificationTimeRepository drinkNotificationTimeRepository) {
        this.memberService = memberService;
        this.drinkNotificationTimeRepository = drinkNotificationTimeRepository;
    }

    // 사용자의 수분 섭취 알림 시간을 찾고, Front 로 보냄
    public DrinkNotificationTimeResponse findDrinkNotificationTime(Long memberId) {
        if (!memberService.existsById(memberId)) {
            throw new EntityNotFoundException("존재하지 않는 멤버입니다.");
        }
        List<DrinkNotificationTime> drinkNotificationTimes = drinkNotificationTimeRepository.findByMemberIdOrderByDrinkTime(memberId);
        return DrinkNotificationTimeResponse.from(drinkNotificationTimes);
    }

    // 사용자가 처음 수분 섭취 알림 시간 설정하면 데이터베이스에 저장
    @Transactional
    public void createDrinkNotificationTimes(DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        Long memberId = drinkNotificationTimeRequest.getId();
        Member member = memberService.findById(memberId);

        if (drinkNotificationTimeRepository.existsByMemberId(memberId)) {
            throw new DrinkException("알림 시간 목록이 이미 존재합니다.", HttpStatus.BAD_REQUEST);
        }

        List<DrinkNotificationTime> drinkNotificationTimes = drinkNotificationTimeRequest.getDrinkNotificationTimes()
                                                                                         .stream()
                                                                                         .map(drinkNotificationTime -> new DrinkNotificationTime(member, drinkNotificationTime))
                                                                                         .collect(Collectors.toList());
        drinkNotificationTimeRepository.saveAll(drinkNotificationTimes);
    }

    // 사용자가 수분 섭취 알림 시간을 변경하면 알림 시간을 변경해줌
    @Transactional
    public void setDrinkNotificationTime(DrinkNotificationTimeRequest drinkNotificationTimeRequest) {
        Member member = memberService.findById(drinkNotificationTimeRequest.getId());

        List<DrinkNotificationTime> drinkNotificationTimes = drinkNotificationTimeRequest.getDrinkNotificationTimes().stream()
                                                                          .map(drinkNotificationTime -> new DrinkNotificationTime(member, drinkNotificationTime))
                                                                          .collect(Collectors.toList());
        member.setDrinkNotificationTimes(drinkNotificationTimes);
    }
}

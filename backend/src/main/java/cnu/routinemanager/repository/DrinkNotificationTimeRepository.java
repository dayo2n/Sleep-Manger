package cnu.routinemanager.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.domain.DrinkNotificationTime;

// 수분 섭취 알림 시간 관련 데이터 베이스

public interface DrinkNotificationTimeRepository extends JpaRepository<DrinkNotificationTime, Long> {
    //현재 Id가 존재하는지
    boolean existsByMemberId(Long memberId);
    // 회원의 수분 섭취 알림 시간 찾기
    List<DrinkNotificationTime> findByMemberIdOrderByDrinkTime(Long memberId);
}

package cnu.routinemanager.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.domain.DrinkNotificationTime;

public interface DrinkNotificationTimeRepository extends JpaRepository<DrinkNotificationTime, Long> {
    boolean existsByMemberId(Long memberId);
    List<DrinkNotificationTime> findByMemberIdOrderByDrinkTime(Long memberId);
}

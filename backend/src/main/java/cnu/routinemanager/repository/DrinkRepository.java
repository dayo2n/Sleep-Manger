package cnu.routinemanager.repository;

import cnu.routinemanager.domain.Drink;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

// 수분 섭취 기록 관련 데이터 베이스
public interface DrinkRepository extends JpaRepository<Drink, Long> {
    // 회원의 Id와 해당 날짜 수분 기록이 존재하는지
    boolean existsByMemberIdAndDate(Long id, LocalDate date);
    // 회원 Id와 날짜 찾기 
    Optional<Drink> findByMemberIdAndDate(Long memberId, LocalDate date);
    // 회원의 특정 기간 동안의 수분 섭취 기록 찾기
    List<Drink> findByMemberIdAndDateBetweenOrderByDate(Long memberId, LocalDate startDate, LocalDate endDate);
}

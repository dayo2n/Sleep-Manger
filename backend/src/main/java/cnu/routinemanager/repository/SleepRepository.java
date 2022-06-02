package cnu.routinemanager.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.domain.Sleep;

public interface SleepRepository extends JpaRepository<Sleep, Long> {
    boolean existsByMemberIdAndDate(Long id, LocalDate date);
    Optional<Sleep> findByMemberIdAndDate(Long memberId, LocalDate date);
    List<Sleep> findByMemberIdAndDateBetween(Long memberId, LocalDate startDate, LocalDate endDate);
}

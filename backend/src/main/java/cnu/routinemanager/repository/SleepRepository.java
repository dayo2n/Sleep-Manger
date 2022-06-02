package cnu.routinemanager.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import cnu.routinemanager.domain.Sleep;

public interface SleepRepository extends JpaRepository<Sleep, Long> {
    boolean existsByMemberIdAndDate(Long id, LocalDate date);
}

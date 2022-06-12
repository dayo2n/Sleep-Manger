package cnu.routinemanager.repository;

import cnu.routinemanager.domain.Drink;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface DrinkRepository extends JpaRepository<Drink, Long> {
    boolean existsByMemberIdAndDate(Long id, LocalDate date);
    Optional<Drink> findByMemberIdAndDate(Long memberId, LocalDate date);
    List<Drink> findByMemberIdAndDateBetweenOrderByDate(Long memberId, LocalDate startDate, LocalDate endDate);
}

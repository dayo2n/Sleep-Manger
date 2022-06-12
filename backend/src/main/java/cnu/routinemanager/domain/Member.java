package cnu.routinemanager.domain;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

import org.springframework.http.HttpStatus;

import cnu.routinemanager.exception.DrinkException;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@DynamicInsert
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Embedded
    private GoalSleep goalSleep;

    @OneToMany(mappedBy = "member", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    private List<Sleep> sleeps = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DrinkNotificationTime> drinkNotificationTimes = new ArrayList<>();

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Drink> drinks = new ArrayList<>();

    public Member(String email) {
        this.email = email;
    }

    public Member(Long id, String email) {
        this.id = id;
        this.email = email;
    }

    public void setGoalSleep(GoalSleep goalSleep) {
        this.goalSleep = goalSleep;
    }

    public void setDrinkNotificationTimes(List<DrinkNotificationTime> drinkNotificationTimes) {
        this.drinkNotificationTimes.clear();
        this.drinkNotificationTimes.addAll(drinkNotificationTimes);
    }

    public boolean hasDrinkRecordOn(LocalDate date) {
        return drinks.stream()
                     .anyMatch(drink -> drink.hasSameDate(date));
    }

    public void addDrinkAmount(LocalDate date, int amount) {
        Drink existingDrink = drinks.stream()
                                    .filter(drink -> drink.hasSameDate(date)).findAny()
                                    .orElseThrow(() -> new DrinkException("해당 날짜의 수분 섭취 기록이 존재하지 않습니다.", HttpStatus.NOT_FOUND));

        existingDrink.addAmount(amount);
    }

    public void modifyDrinkAmount(LocalDate date, int amount) {
        if (!hasDrinkRecordOn(date)) {
            throw new DrinkException("해당 날짜의 수분 섭취 기록이 존재하지 않습니다.", HttpStatus.NOT_FOUND);
        }

        Drink existingDrink = drinks.stream()
                                    .filter(drink -> drink.hasSameDate(date)).findAny()
                                    .get();
        existingDrink.modifyAmount(amount);
    }
}

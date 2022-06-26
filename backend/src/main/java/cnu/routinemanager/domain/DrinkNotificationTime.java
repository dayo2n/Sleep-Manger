package cnu.routinemanager.domain;

import java.time.LocalTime;
import javax.persistence.*;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class DrinkNotificationTime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @Column
    private LocalTime drinkTime;

    // 알림 시간 설정
    public DrinkNotificationTime(LocalTime drinkTime) {
        this.drinkTime = drinkTime;
    }

    // 알림 시간 설정정
   public DrinkNotificationTime(Member member, LocalTime drinkTime) {
        this.member = member;
        this.drinkTime = drinkTime;
    }
}

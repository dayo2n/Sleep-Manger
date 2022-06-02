package cnu.routinemanager.domain;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

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

    public Member(String email) {
        this.email = email;
    }

    public Member(Long id, String email) {
        this.id = id;
        this.email = email;
    }

    public void setGoalSleep(LocalTime goalBedTime, LocalTime goalWakeUpTime, LocalTime weekendGoalBedTime, LocalTime weekendGoalWakeUpTime) {
        goalSleep.setGoalBedTime(goalBedTime);
        goalSleep.setGoalWakeUpTime(goalWakeUpTime);
        goalSleep.setWeekendGoalBedTime(weekendGoalBedTime);
        goalSleep.setWeekendGoalWakeUpTime(weekendGoalWakeUpTime);
    }
}

package cnu.routinemanager.domain;

import java.time.LocalTime;
import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Embeddable
public class GoalSleep {
    @Column(columnDefinition = "time default 0")
    private LocalTime goalBedTime;

    @Column(columnDefinition = "time default 0")
    private LocalTime goalWakeUpTime;

    @Column(columnDefinition = "time default 0")
    private LocalTime weekendGoalBedTime;

    @Column(columnDefinition = "time default 0")
    private LocalTime weekendGoalWakeUpTime;
}

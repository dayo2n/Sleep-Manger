package cnu.routinemanager.dto.request;

import java.time.LocalTime;
import javax.validation.constraints.NotNull;

import cnu.routinemanager.domain.GoalSleep;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class GoalSleepTimeRequest {
    @NotNull
    private Long id;

    @NotNull
    private LocalTime goalBedTime;

    @NotNull
    private LocalTime goalWakeUpTime;

    private LocalTime weekendGoalBedTime;

    private LocalTime weekendGoalWakeUpTime;

    public GoalSleep toGoalSleep() {
        return new GoalSleep(
                goalBedTime,
                goalWakeUpTime,
                weekendGoalBedTime,
                weekendGoalWakeUpTime
        );
    }
}

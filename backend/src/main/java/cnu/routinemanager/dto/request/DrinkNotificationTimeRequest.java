package cnu.routinemanager.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.time.LocalTime;
import java.util.List;

// Front 에서 수분 알림 시간을 받을때 request body
@Getter
@NoArgsConstructor
public class DrinkNotificationTimeRequest {
    @NotNull
    private Long id;

    @NotNull
    private List<LocalTime> drinkNotificationTimes;
}

package cnu.routinemanager.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.time.LocalTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class DrinkNotificationTimeRequest {
    @NotNull
    private Long id;

    @NotNull
    private List<LocalTime> drinkNotificationTimes;
}

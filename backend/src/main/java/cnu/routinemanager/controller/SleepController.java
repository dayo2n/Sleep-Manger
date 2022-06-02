package cnu.routinemanager.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import cnu.routinemanager.dto.request.GoalSleepTimeRequest;
import cnu.routinemanager.dto.response.GoalSleepResponse;
import cnu.routinemanager.service.GoalSleepService;

@RestController
@RequestMapping("/sleeps")
public class SleepController {
    private final GoalSleepService goalSleepService;

    public SleepController(GoalSleepService goalSleepService) {
        this.goalSleepService = goalSleepService;
    }

    @GetMapping(value = "goals")
    public ResponseEntity<GoalSleepResponse> findGoalSleepTime(@RequestParam(value = "id") Long id) {
        GoalSleepResponse goalSleepTimeResponse = goalSleepService.findGoalSleepTime(id);
        return ResponseEntity.ok()
                             .body(goalSleepTimeResponse);
    }

    @PostMapping(value = "goals")
    public ResponseEntity<Void> setGoalSleepTime(@Valid @RequestBody GoalSleepTimeRequest goalSleepTimeRequest) {
        goalSleepService.setGoalSleepTime(goalSleepTimeRequest);
        return ResponseEntity.status(HttpStatus.CREATED)
                             .build();
    }

}

package cnu.routinemanager.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
}

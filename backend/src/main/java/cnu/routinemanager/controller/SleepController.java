package cnu.routinemanager.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import cnu.routinemanager.dto.request.DaySleepRecordRequest;
import cnu.routinemanager.dto.request.GoalSleepTimeRequest;
import cnu.routinemanager.dto.response.GoalSleepResponse;
import cnu.routinemanager.service.GoalSleepService;
import cnu.routinemanager.service.SleepService;

@RestController
@RequestMapping("/sleeps")
public class SleepController {
    private final GoalSleepService goalSleepService;
    private final SleepService sleepService;

    public SleepController(GoalSleepService goalSleepService, SleepService sleepService) {
        this.goalSleepService = goalSleepService;
        this.sleepService = sleepService;
    }

    @GetMapping(value = "goals")
    public ResponseEntity<GoalSleepResponse> findGoalSleepTime(@RequestParam(value = "id") Long id) {
        GoalSleepResponse goalSleepTimeResponse = goalSleepService.findGoalSleepTime(id);
        return ResponseEntity.ok()
                             .body(goalSleepTimeResponse);
    }

    @PutMapping(value = "goals")
    public ResponseEntity<Void> setGoalSleepTime(@Valid @RequestBody GoalSleepTimeRequest goalSleepTimeRequest) {
        goalSleepService.setGoalSleepTime(goalSleepTimeRequest);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @PostMapping(value = "day")
    public ResponseEntity<Void> createDaySleepRecord(@Valid @RequestBody DaySleepRecordRequest daySleepRecordRequest ) {
        sleepService.createDaySleepRecord(daySleepRecordRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }
}

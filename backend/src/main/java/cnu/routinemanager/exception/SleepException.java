package cnu.routinemanager.exception;

import org.springframework.http.HttpStatus;

public class SleepException extends SleepManagerException {
    public SleepException(String message) {
        super(message, HttpStatus.BAD_REQUEST);
    }
}

package cnu.routinemanager.exception;

import org.springframework.http.HttpStatus;

public class SleepManagerException extends RuntimeException {
    private final HttpStatus httpStatus;

    public SleepManagerException(String message, HttpStatus httpStatus) {
        super(message);
        this.httpStatus = httpStatus;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}

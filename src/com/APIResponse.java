package com;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Standardized API Response Model for consistent error and success responses
 */
public class APIResponse {

    private boolean success;
    private String message;
    private String error;
    private Object data;
    private long timestamp;
    private int statusCode;

    public APIResponse() {
        this.timestamp = System.currentTimeMillis();
    }

    public APIResponse(boolean success, String message) {
        this();
        this.success = success;
        this.message = message;
    }

    public APIResponse(boolean success, String message, Object data) {
        this(success, message);
        this.data = data;
    }

    public APIResponse(boolean success, String error, String message, int statusCode) {
        this();
        this.success = success;
        this.error = error;
        this.message = message;
        this.statusCode = statusCode;
    }

    // Static factory methods for common responses
    public static APIResponse success(String message) {
        return new APIResponse(true, message);
    }

    public static APIResponse success(String message, Object data) {
        return new APIResponse(true, message, data);
    }

    public static APIResponse error(String error, String message, int statusCode) {
        return new APIResponse(false, error, message, statusCode);
    }

    public static APIResponse badRequest(String message) {
        return error("Bad Request", message, 400);
    }

    public static APIResponse notFound(String message) {
        return error("Not Found", message, 404);
    }

    public static APIResponse conflict(String message) {
        return error("Conflict", message, 409);
    }

    public static APIResponse internalServerError(String message) {
        return error("Internal Server Error", message, 500);
    }

    public static APIResponse validationError(String message) {
        return error("Validation Error", message, 400);
    }

    // Convert to JSON
    // FIXED: Added "throws JSONException" to handle the checked exception from json.put()
    public JSONObject toJSON() throws JSONException {
        JSONObject json = new JSONObject();
        json.put("success", success);
        json.put("timestamp", timestamp);

        if (message != null) {
            json.put("message", message);
        }

        if (error != null) {
            json.put("error", error);
        }

        if (data != null) {
            json.put("data", data);
        }

        if (statusCode > 0) {
            json.put("statusCode", statusCode);
        }

        return json;
    }

    // Getters and Setters
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }
}

package com.cloudlab.multitenant.config;

/**
 * A context holder for tenant ID using ThreadLocal
 * This allows tenant information to be accessible throughout the request lifecycle
 */
public class TenantContext {
    private static final ThreadLocal<String> CURRENT_TENANT = new ThreadLocal<>();

    private TenantContext() {
        // Private constructor to prevent instantiation
    }

    /**
     * Sets the current tenant ID for this thread
     * @param tenantId The tenant identifier
     */
    public static void setCurrentTenant(String tenantId) {
        CURRENT_TENANT.set(tenantId);
    }

    /**
     * Gets the current tenant ID from the thread context
     * @return The current tenant ID
     */
    public static String getCurrentTenant() {
        return CURRENT_TENANT.get();
    }

    /**
     * Clears the tenant ID from the current thread
     * Should be called at the end of request processing
     */
    public static void clear() {
        CURRENT_TENANT.remove();
    }
}
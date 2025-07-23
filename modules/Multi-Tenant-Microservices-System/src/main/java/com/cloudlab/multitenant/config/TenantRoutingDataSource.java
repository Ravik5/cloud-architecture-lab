package com.cloudlab.multitenant.config;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * A DataSource that routes to tenant-specific schemas based on a ThreadLocal context
 */
public class TenantRoutingDataSource extends AbstractRoutingDataSource {

    @Override
    protected Object determineCurrentLookupKey() {
        return TenantContext.getCurrentTenant();
    }
}
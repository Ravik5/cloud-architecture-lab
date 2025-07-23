package com.cloudlab.multitenant.repository;

import com.cloudlab.multitenant.entity.Tenant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Repository interface for managing Tenant entities.
 * Provides CRUD operations and query methods for tenants.
 */
@Repository
public interface TenantRepository extends JpaRepository<Tenant, String> {
    // Add custom query methods if needed
}
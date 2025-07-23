package com.cloudlab.multitenant.service;

import com.cloudlab.multitenant.entity.Tenant;
import com.cloudlab.multitenant.repository.TenantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Service for managing tenants and their schemas.
 */
@Service
public class TenantService {

    private final TenantRepository tenantRepository;
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public TenantService(TenantRepository tenantRepository, JdbcTemplate jdbcTemplate) {
        this.tenantRepository = tenantRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Creates a new tenant and sets up its schema dynamically.
     * @param id Tenant ID
     * @param name Tenant name
     * @param schema Schema name
     * @return The created Tenant entity
     */
    public Tenant createTenant(String id, String name, String schema) {
        String createSchemaSql = "CREATE SCHEMA IF NOT EXISTS " + schema;
        jdbcTemplate.execute(createSchemaSql);

        Tenant tenant = new Tenant();
        tenant.setId(id);
        tenant.setName(name);
        tenant.setSchema(schema);
        tenant.setActive(true);
        tenant.setCreatedAt(LocalDateTime.now());
        tenant.setUpdatedAt(LocalDateTime.now());

        return tenantRepository.save(tenant);
    }

    /**
     * Retrieves all tenants.
     * @return List of Tenant entities
     */
    public List<Tenant> getAllTenants() {
        return tenantRepository.findAll();
    }

    /**
     * Retrieves a tenant by its ID.
     * @param id Tenant ID
     * @return Tenant entity with the specified ID, or null if not found
     */
    public Tenant getTenantById(String id) {
        Optional<Tenant> tenant = tenantRepository.findById(id);
        return tenant.orElse(null);
    }

    /**
     * Updates an existing tenant.
     * @param id Tenant ID
     * @param updatedTenant Tenant object with updated details
     * @return The updated Tenant entity, or null if not found
     */
    public Tenant updateTenant(String id, Tenant updatedTenant) {
        Optional<Tenant> existingTenantOpt = tenantRepository.findById(id);
        if (existingTenantOpt.isPresent()) {
            Tenant existingTenant = existingTenantOpt.get();
            existingTenant.setName(updatedTenant.getName());
            existingTenant.setSchema(updatedTenant.getSchema());
            existingTenant.setActive(updatedTenant.isActive());
            existingTenant.setUpdatedAt(LocalDateTime.now());
            return tenantRepository.save(existingTenant);
        }
        return null;
    }

    /**
     * Deletes a tenant by its ID.
     * @param id Tenant ID
     */
    public void deleteTenant(String id) {
        tenantRepository.deleteById(id);
    }
}
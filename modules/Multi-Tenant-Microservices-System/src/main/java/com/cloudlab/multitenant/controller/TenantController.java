package com.cloudlab.multitenant.controller;

import com.cloudlab.multitenant.entity.Tenant;
import com.cloudlab.multitenant.service.TenantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST controller for managing tenants.
 * Provides endpoints for creating, retrieving, updating, and deleting tenants.
 */
@RestController
@RequestMapping("/api/tenants")
public class TenantController {

    private final TenantService tenantService;

    /**
     * Constructs a TenantController with the specified TenantService.
     * @param tenantService Service for tenant operations
     */
    @Autowired
    public TenantController(TenantService tenantService) {
        this.tenantService = tenantService;
    }

    /**
     * Creates a new tenant and sets up its schema.
     * @param tenant Tenant object containing details
     * @return The created Tenant entity
     */
    @PostMapping
    public Tenant createTenant(@RequestBody Tenant tenant) {
        return tenantService.createTenant(tenant.getId(), tenant.getName(), tenant.getSchema());
    }

    /**
     * Retrieves all tenants.
     * @return List of Tenant entities
     */
    @GetMapping
    public List<Tenant> getAllTenants() {
        return tenantService.getAllTenants();
    }

    /**
     * Retrieves a tenant by its ID.
     * @param id Tenant ID
     * @return Tenant entity with the specified ID
     */
    @GetMapping("/{id}")
    public Tenant getTenantById(@PathVariable String id) {
        return tenantService.getTenantById(id);
    }

    /**
     * Updates an existing tenant.
     * @param id Tenant ID
     * @param tenant Tenant object with updated details
     * @return The updated Tenant entity
     */
    @PutMapping("/{id}")
    public Tenant updateTenant(@PathVariable String id, @RequestBody Tenant tenant) {
        return tenantService.updateTenant(id, tenant);
    }

    /**
     * Deletes a tenant by its ID.
     * @param id Tenant ID
     */
    @DeleteMapping("/{id}")
    public void deleteTenant(@PathVariable String id) {
        tenantService.deleteTenant(id);
    }
}
package com.cloudlab.multitenant.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * JPA entity representing tenant metadata for multi-tenant applications.
 * Stores information such as tenant ID, name, schema, status, and audit timestamps.
 */
@Entity
@Table(name = "tenants")
@Data
public class Tenant {

    /**
     * Unique identifier for the tenant.
     */
    @Id
    private String id;

    /**
     * Display name of the tenant.
     */
    @Column(nullable = false)
    private String name;

    /**
     * Database schema name associated with the tenant.
     */
    @Column(nullable = false, unique = true)
    private String schema;

    /**
     * Flag indicating whether the tenant is active.
     */
    @Column(nullable = false)
    private boolean active = true;

    /**
     * Timestamp when the tenant was created.
     */
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    /**
     * Timestamp when the tenant was last updated.
     */
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
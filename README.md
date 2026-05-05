# Concurrent Railroad Network Simulation (Ada)

## Overview

This project simulates a concurrent railroad network system using Ada. It models multiple trains navigating shared track infrastructure while coordinating access to critical sections, logging events, and maintaining a global simulation clock.

The system demonstrates safe resource sharing, synchronization, and event-driven architecture using Ada’s tasks and protected objects.

---

## Features

### Multi-Train Concurrency

* Multiple train tasks run simultaneously
* Each train follows a predefined route across shared track sections
* Realistic blocking behavior when track sections are occupied

### Safe Track Allocation (Critical Section Control)

* Each track section is a protected object
* Trains must **request access** before entering a section
* Ensures:

  * No collisions
  * Mutual exclusion
  * Safe handoff between trains

### Dispatcher Monitoring System

* Central dispatcher task monitors network state
* Displays real-time occupancy of track sections
* Provides visibility into system behavior during execution

### Event Logging System

* Centralized logging via a thread-safe event queue
* **Dual logging formats:**

  * `railroad_log.csv` → human-readable logs
  * `railroad_log.dat` → binary format for efficient processing
* Logs include:

  * Train ID
  * Section ID
  * Event message

### Simulation Clock

* Global clock task drives simulation timing
* Coordinates start/stop conditions
* Ensures consistent progression across all tasks

### Network Modeling

* Railway network built using:

  * Section maps
  * Route lists
* Predefined routes between cities (e.g., Minneapolis → Chicago)

---

## Technologies

* Ada (GNAT toolchain)
* Alire
* Concurrency:

  * Tasks
  * Protected Objects
* Data Structures:

  * Maps, Vectors, Linked Lists (Ada Containers)

---

## Project Structure

```id="v7fl5q"
railroad-simulation/
│
├── src/
│   ├── railroad.adb
│   ├── railroad_logic.ads
│   ├── railroad_logic.adb
│   ├── network.ads
│   ├── network.adb
│   ├── train_tasks.ads
│   ├── train_tasks.adb
│   ├── dispatchers.ads
│   ├── dispatchers.adb
│   ├── loggers.ads
│   ├── loggers.adb
│   ├── sim_clocks.ads
│   ├── sim_clocks.adb
│
├── alire.toml
├── railroad.gpr
├── README.md
└── .gitignore
```

---

## How to Build and Run

Ensure Alire is installed:

```bash id="iqsq06"
alr build
alr run
```

---

## Example Behavior

* Trains request track sections and block if occupied
* Dispatcher prints live network occupancy
* Logger records all events to CSV and binary formats
* Simulation runs until a maximum tick count is reached

---

## Key Concepts Demonstrated

* Concurrent system design
* Resource allocation and mutual exclusion
* Producer-consumer pattern (event queue)
* Real-time simulation using a global clock
* Separation of concerns across modules
* Logging systems (text + binary)

---

## Future Improvements

* Deadlock detection and avoidance strategies
* Dynamic routing or scheduling algorithms
* Visualization of the rail network
* Priority-based dispatching
* Performance metrics (throughput, wait time)

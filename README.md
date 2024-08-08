# Set Calculator Project README

## Project Overview

The Set Calculator is a Ruby-based command-line application that enables manipulation and calculation of numerical sets represented as Binary Search Trees (BSTs), providing functionalities such as union, intersection, and the unique ability to perform operations without duplicating data across the sets X, Y, and Z.

## Technical Description

The application manages three sets (X, Y, and Z) through a series of commands that allow users to perform various set operations. Each set is implemented using a BST, which enhances both the speed of data retrieval and insertion while maintaining the data in sorted order. This sorted order is achieved via in-order traversal, which is critical for operations like printing the set in ascending order.

### Key Technical Features

- **Dynamic Set Management:** Each set can dynamically grow as new elements are inserted, ensuring that no duplicates are stored.
- **Set Operations:** Implements set union and intersection by leveraging BST properties to maintain order and uniqueness.
- **Lambda Expressions:** Supports the application of lambda expressions to elements of set X, showcasing the flexibility of Ruby's handling of higher-order functions.
- **Robust Memory Handling:** Utilizes deep copying to ensure that operations like copying a set do not result in shared memory references, thereby preventing inadvertent data manipulation across sets.

## Core Functionalities

- **Initialization and Direct Manipulation:** Commands like `X values`, `Y values`, and `Z values` reset the respective sets with new values, replacing all previous contents.
- **Element Insertion:** The `a i` command inserts a new integer into set X, preserving the BST structure.
- **Content Rotation and Switching:** Commands like `r` and `s` rotate and switch the contents of the sets, facilitating easy manipulation of data context without deep copying.
- **Set Union and Intersection:** The `u` and `i` commands provide the ability to compute the union and intersection of sets X and Y, storing the result back into set X.
- **Deep Copying:** The `c` command deeply copies the contents of set X into set Y, ensuring no shared references.

## Files Included

- **set_calculator.rb:** The main Ruby script that implements the Set Calculator functionalities.

## Compilation and Execution

To compile and run the Set Calculator, use the provided Makefile with the following commands:

- **Compile and Run:**
  ```bash
  make run
  ```

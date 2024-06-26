// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VTOP_HW14_1__SYMS_H_
#define _VTOP_HW14_1__SYMS_H_  // guard

#include "verilated_heavy.h"

// INCLUDE MODULE CLASSES
#include "Vtop_Hw14_1.h"
#include "Vtop_Hw14_1___024unit.h"

// SYMS CLASS
class Vtop_Hw14_1__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vtop_Hw14_1*                   TOPp;
    
    // CREATORS
    Vtop_Hw14_1__Syms(Vtop_Hw14_1* topp, const char* namep);
    ~Vtop_Hw14_1__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard

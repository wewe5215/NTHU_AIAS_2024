// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtop_Hw14_1__Syms.h"
#include "Vtop_Hw14_1.h"
#include "Vtop_Hw14_1___024unit.h"



// FUNCTIONS
Vtop_Hw14_1__Syms::Vtop_Hw14_1__Syms(Vtop_Hw14_1* topp, const char* namep)
    // Setup locals
    : __Vm_namep(namep)
    , __Vm_activity(false)
    , __Vm_didInit(false)
    // Setup submodule names
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
}

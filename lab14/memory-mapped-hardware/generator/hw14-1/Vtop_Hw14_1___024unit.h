// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_Hw14_1.h for the primary calling header

#ifndef _VTOP_HW14_1___024UNIT_H_
#define _VTOP_HW14_1___024UNIT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vtop_Hw14_1__Syms;
class Vtop_Hw14_1_VerilatedVcd;


//----------

VL_MODULE(Vtop_Hw14_1___024unit) {
  public:
    
    // INTERNAL VARIABLES
  private:
    Vtop_Hw14_1__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vtop_Hw14_1___024unit);  ///< Copying not allowed
  public:
    Vtop_Hw14_1___024unit(const char* name = "TOP");
    ~Vtop_Hw14_1___024unit();
    
    // INTERNAL METHODS
    void __Vconfigure(Vtop_Hw14_1__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard

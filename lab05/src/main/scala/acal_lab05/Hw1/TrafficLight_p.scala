package acal_lab05.Hw1

import chisel3._
import chisel3.util._

class TrafficLight_p(Ytime:Int, Gtime:Int, Ptime:Int) extends Module{
  val io = IO(new Bundle{
    val P_button = Input(Bool())
    val H_traffic = Output(UInt(2.W))
    val V_traffic = Output(UInt(2.W))
    val P_traffic = Output(UInt(2.W))
    val timer     = Output(UInt(5.W))
  })

  //please implement your code below...
  io.H_traffic := 0.U
  io.V_traffic := 0.U
  io.P_traffic := 0.U
  io.timer := 0.U
  //parameter declaration
  val Off = 0.U
  val Red = 1.U
  val Yellow = 2.U
  val Green = 3.U

  val sIdle :: sHGVR :: sHYVR :: sHRVG :: sHRVY :: sPG :: Nil = Enum(6)

  //State register
  val state = RegInit(sIdle)
  val last_state = RegInit(sIdle)
  val is_p_button = RegInit(0.U(1.W))
  val last_is_p_button = RegInit(0.U(1.W))
  //Counter============================
  val cntMode = WireDefault(0.U(2.W))
  val cntReg = RegInit(0.U(4.W))
  val cntDone = Wire(Bool())
  cntDone := cntReg === 0.U


  when(cntDone){
    when(cntMode === 0.U){
      cntReg := (Gtime-1).U
    }.elsewhen(cntMode === 1.U){
      cntReg := (Ytime-1).U
    }.elsewhen(cntMode === 2.U){
      cntReg := (Ptime-1).U
    }
  }
  .otherwise{
    when(io.P_button){
      when(state =/= sPG){
        cntReg := (Ptime-1).U
      }.otherwise{
        cntReg := cntReg - 1.U
      }
    }
    .otherwise{
      cntReg := cntReg - 1.U
    }
  }

  when(io.P_button){
    when(state =/= sPG){
      is_p_button := 1.U(1.W)
    }
    .otherwise{
      is_p_button := 0.U(1.W)
    }
  }
  .otherwise{
    when(state === sPG){
      is_p_button := is_p_button
    }
    .otherwise{
      is_p_button := 0.U(1.W)
    }
  }
  //Counter end========================


  //Next State Decoder
  switch(state){
    is(sIdle){
      state := sHGVR
      last_state := sIdle
    }
    is(sHGVR){
      when(io.P_button){
        state := sPG
        last_state := sHGVR
      }
      .otherwise{
        when(cntDone) {
          state := sHYVR
          last_state := sHGVR
        }
      }
    }
    is(sHYVR){
      when(io.P_button){
        state := sPG
        last_state := sHYVR
      }
      .otherwise{
        when(cntDone) {
          state := sHRVG
          last_state := sHYVR
        }
      }
    }
    is(sHRVG){
      when(io.P_button){
        state := sPG
        last_state := sHRVG
      }
      .otherwise{
        when(cntDone) {
          state := sHRVY
          last_state := sHRVG
        }
      }
    }
    is(sHRVY){
      when(io.P_button){
        state := sPG
        last_state := sHRVY
      }
      .otherwise{
        when(cntDone) {
          state := sPG
          last_state := sHRVY
        }
      }
    }
    is(sPG){
      when(cntDone) {
        when(is_p_button === 1.U){
          state := last_state
          last_state := sPG
        }
        .otherwise{
          state := sHGVR
          last_state := sPG
        }
      }
    }
  }

  //Output Decoder
  //Default statement
  cntMode := 0.U
  io.H_traffic := Off
  io.V_traffic := Off

  switch(state){
    is(sHGVR){
      cntMode := 1.U
      io.H_traffic := Green
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHYVR){
      cntMode := 0.U
      io.H_traffic := Yellow
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHRVG){
      cntMode := 1.U
      io.H_traffic := Red
      io.V_traffic := Green
      io.P_traffic := Red
    }
    is(sHRVY){
      cntMode := 2.U
      io.H_traffic := Red
      io.V_traffic := Yellow
      io.P_traffic := Red
    }
    is(sPG){
      cntMode := 0.U
      io.H_traffic := Red
      io.V_traffic := Red
      io.P_traffic := Green
    }
  }

  io.timer := cntReg
}
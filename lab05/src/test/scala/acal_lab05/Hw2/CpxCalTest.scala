package acal_lab05.Hw2

import chisel3.iotesters.{Driver,PeekPokeTester}
import scala.language.implicitConversions

class CpxCalTest(dut:CpxCal) extends PeekPokeTester(dut){

    val dict = Map(
      '0' -> 0,
      '1' -> 1,
      '2' -> 2,
      '3' -> 3,
      '4' -> 4,
      '5' -> 5,
      '6' -> 6,
      '7' -> 7,
      '8' -> 8,
      '9' -> 9,
      '+' -> 10,
      '-' -> 11,
      '*' -> 12,
      '(' -> 13,
      ')' -> 14,
      '=' -> 15
    )
val num = BigInt("5360161621086697477532205257084500572")
    val golden = Seq(("50=",50),
                     ("30+40=",70),
                     ("30-40=",-10),
                     ("20*20=",400),
                     ("(-123)=",-123),
                     ("(-10)+11+12-(-13)+(-14)=",12),
                     ("((-15)+(-10))*12-(34+66)*(-4)=",100),
                     ("((-123)*((-32)+3)*4+(15-(-16)))*(((-4)-2)*((-2)+1))=", 85794),
                     ("(5+3)*(7-8)+((-3)*(7+3)*(8+9)-7)*((3+4)-3)=",-2076),
                     ("(((((((((8-3)*2-4)*3-2)*4-1)*3+5)*2-1)*3+2)*2+4)*3+8)*4-1234567890*98271811098-244817292034*(674373294052-3472781923742)*7823924729230=",num))
                     //you can add your own formular for testing

    golden.zipWithIndex.foreach{ case((input,output),index)=>
        input.foreach{ ch =>
            poke(dut.io.key_in,dict(ch))
            step(1)
        }
        while(peek(dut.io.value.valid) == 0){
            step(1)
        }
        // assert(peek(dut.io.value.bits).toInt == output)
        println("Question"+(index+1).toString+": "+input)
        println("the output of module is :" + peek(dut.io.value.bits).toInt)
        println("the correct answer is :" + output)
        println(if(peek(dut.io.value.bits).toInt==output) "Correct" else "Wrong")
        println("==========================================")
        step(1)
    }
}

object CpxCalTest extends App{
    Driver.execute(args,()=>new CpxCal){
        c:CpxCal => new CpxCalTest(c)
    }
}
namespace Bell
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    // So desired is a variable of type result, 
    // and q1 is a variable of type Qubit
    {
        body
        {
            let current = M(q1);
            if (desired != current)
            {
                X(q1);
            }
            
        }
    }


    // Finally understood what the function below does!
    // So, say I have a state, and I want its statistics when I apply a Z measurement on it/
    // So, count times, I take a qubit, prepare it in the state, and perform a Z measurement
    // And I return how many times I got a one, and how many times I got a zero.

    // But there's an issue. Doesn't 'Set' only set qubits to Zero or One?

    operation BellTest (count: Int, initial: Result) : (Int,Int)
    // count is a variable of type Int, 
    // and initial is a variable of type Result.
    // So the output of M can be stored in initial
    {
        body
        {
            mutable numOnes = 0;
            using (qubits = Qubit[1])  // apparently the keyword 'borrowing' is used for ancilla bits
            {
                for (test in 1..count)
                {
                    Set(initial, qubits[0]);

                    let res = M (qubits[0]); // let is for binding immutable variables

                    // Count number of ones we saw:
                    if (res == One) // So Zero and One are the literals of type Result
                    {
                        set numOnes = numOnes + 1; // set is for setting mutable variables
                    }
                }
                Set(Zero, qubits[0]);
            }
            // Return the number of times we saw a |0> and number of times we saw a |1>
            return (count - numOnes, numOnes);
        }
    }
}

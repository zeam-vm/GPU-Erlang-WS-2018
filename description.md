# Introduction

* TensorFlow \cite{TensorFlow}, Keras \cite{Keras} 
* GPGPU \cite{Nickolls:2008:SPP:1401132.1401152}
* Elixir \cite{Elixir} \cite{Elixir16}

# Principle

* Our previous work \cite{ZACKY18}
* MapReduce \cite{Dean:2008:MSD:1327452.1327492}
* Flow \cite{Flow}

# Implementation

* Logistic Maps \cite{Miyazaki14}
* Rust \cite{Rust}, Rustler \cite{Rustler}
* ocl \cite{ocl}

# Performance Evaluation

## Evaluation Environment

We have evaluated two environments: Mac Pro (Mid 2010) and Google Compute Engine(GCE) \cite{GCE}. 

1. Mac Pro (Mid 2010) has one 2.8GHz Quad-Core Intel Xeon with 16GB memories and ATI Radeon HD 5770 with 1024MB memories. 

2. Our GCE settings include as follows:
	* Machine type: custom (8 vCPUs and 16GB memories)
	* CPU platform: Intel Broadwell
	* GPU: one NVIDIA Tesla K80
	* Zone: us-west1-b

The version of OpenCL \cite{OpenCL} is 1.2.

## Benchmarks

We will show the following benchmarks:

* Benchmark1: that is written in only Elixir \cite{Elixir}. The calculation of the logistic maps is implemented using 10 times recursive calls.
* Benchmark3: that is written in only Elixir. The calculation of the logistic maps is inlined inside of Flow \cite{Flow}. 
* Benchmark8: that is written in Elixir and Rust with Rustler \cite{Rustler}. The logistic maps are calculated by CPU with the native code in Rust \cite{Rust}.
* Benchmark9: that is written in Elixir and Rust with Rustler. The logistic maps are calculated by GPU via OpenCL \cite{OpenCL} with the native code in Rust and ocl \cite{ocl}.
* Empty: that is a dummy benchmark to be compared from a efficient point of view. It includes conversions between expressions of a list in Elixir and a vector in Rust, though it does not include the caliculation.
* Rust\_CPU: that is written in only Rust. The logistic maps are calculated by CPU.
* Rust\_GPU: that is written in only Rust. The logistic maps are calculated by GPU via OpenCL with ocl.
* Python\_CPU: that is written in only \cite{Python} with NumPy \cite{NumPy}.
* Python\_GPU: that is written in only \cite{Python} with CuPy \cite{CuPy} with GPU.

## Evaluation Result and Discussion

Table \ref{result} shows the result of the benchmarks. 

* Benchmark9 is 1.76--2.12 times faster than pure Elixir (Benchmark1 and Benchmark3).
* The ratio of the difference between Benchmark9 and Empty is 8.29--10.5 percents. We indentify that it is net execution time apart from the overhead of the conversions between expressions of a list in Elixir and a vector in Rust.
* Pure Elixir and Benchmark9 is 1.19--1.53 times and 2.52--2.7 times faster than Python\_CPU, respectively.
* Benchmark9 is almost as fast as Python\_GPU.
* The ratios of the difference between Bnechmark8 and Rust\_CPU and between Benchmark9 and Rust\_GPU is 72.0--78.2 and 71.7--82.3 percents, respectively. We identify that it is the overhead of Erlang VM. 
* Rust\_GPU is 3.54--5.66 times faster than Benchmark9 and Python\_GPU. This is the potential of optimization.

\begin{table*}[t]
\centering
\caption{The result of the benchmarks}
\label{result}
\begin{tabular}{lll|r|r|}
           &                  &              & \multicolumn{1}{l|}{Mac Pro (Mid 2010)} & \multicolumn{1}{l|}{GCE}              \\
           &                  &              & \multicolumn{1}{l|}{2.8GHz Quad-Core Intel Xeon} & \multicolumn{1}{l|}{Intel Broadwell vCPU:8}           \\
           &                  &              & \multicolumn{1}{l|}{ATI Radeon HD 5770} & \multicolumn{1}{l|}{NVIDIA Tesla K80} \\ 
           &                  &              &  (sec)        & (sec) \\ \hline
Benchmark1 & Elixir      & recursive call & 12.80              & 9.537            \\
Benchmark3 & Elixir      & inlining     & 11.57              & 8.020            \\
Benchmark8 & Elixir / Rustler & CPU          & 9.703              & 7.908            \\
\rowcolor[HTML]{C0C0C0} 
Benchmark9 & Elixir / Rustler & OpenCL (GPU) & 6.572              & 4.494            \\
Empty      & Elixir / Rustler & empty        & 6.027              & 4.022            \\
Rust\_CPU  & Rust        & CPU          & 2.721              & 1.723            \\
\rowcolor[HTML]{C0C0C0} 
Rust\_GPU  & Rust        & OpenCL (GPU) & 1.857              & 0.7942           \\
Python\_CPU & Python      & NumPy (CPU)  & 17.75              & 11.34 \\
Python\_GPU & Python      & CuPy (GPU)   & N/A                & 4.316 \\           
\end{tabular}
\end{table*}

# Conclusion and Future Works

We have conducted the performance evaluation of the experimental implementation of GPGPU by Elixir and Rustler. We have got the following result:

* Elixir and Rustler code using GPU is 1.76--2.12 times and 2.52--2.7 times faster than pure Elixir and Python code executed by only CPU, respectively.
* Elixir and Rustler code using GPU is almost as fast as Python code using GPU.
* Native code using GPU is 3.54--5.66 times faster than Elixir and Rustler code and Python code using GPU. This is the potential of optimization.

We realize that Erlang VM is not enough performance for such optimization, including elimination of the conversions between lists and vectors, which is the main reason of the overhead. Thus, We will implement Hastega, which is a new processing system of Elixir, which has a enough ability to drive GPUs and optimize the conversions.

We also have a plan to implement mathematic and machine learning libraries in Elixir, which is implemented using Flow. Of course, we will apply Hastega to the libraries, and compare them with that of Python.

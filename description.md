# Introduction

* TensorFlow \cite{TensorFlow}, Keras \cite{Keras} 
* GPGPU \cite{Nickolls:2008:SPP:1401132.1401152}
* Elixir \cite{Elixir} \cite{Elixir16}

# Implementation

* Our previous work \cite{ZACKY18}
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
* Benchmark3: that is written in only Elixir. The calculation of the logistic maps is inlined inside of Flow. 
* Benchmark8: that is written in Elixir and Rust with Rustler \cite{Rustler}. The logistic maps are calculated by CPU with the native code in Rust \cite{Rust}.
* Benchmark9: that is written in Elixir and Rust with Rustler. The logistic maps are calculated by GPU via OpenCL \cite{OpenCL} with the native code in Rust and ocl \cite{ocl}.
* Empty: that is a dummy benchmark to be compared from a efficient point of view. It includes conversion between expressions of a list in Elixir and a vector in Rust, though it does not include the caliculation.
* Rust\_CPU: that is written in only Rust. The logistic maps are calculated by CPU.
* Rust\_GPU: that is written in only Rust. The logistic maps are calculated by GPU via OpenCL with ocl.
* Python: that is written in only \cite{Python} with NumPy \cite{NumPy}.

## Evaluation Result

Table \ref{result} shows the result of the benchmarks. 



\begin{table*}[]
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
Python     & Python           & NumPy (CPU)  & 17.75              & N/A          
\end{tabular}
\end{table*}
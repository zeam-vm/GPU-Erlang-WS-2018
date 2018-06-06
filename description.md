# Introduction


* GPGPU \cite{Nickolls:2008:SPP:1401132.1401152}

* Our previous work \cite{ZACKY18}

* Elixir \cite{Elixir16}
* TensorFlow \cite{TensorFlow}, Keras \cite{Keras} 
* Logistic Maps \cite{Miyazaki14}

# Performance Evaluation

## Evaluation Environment

We have evaluate two environments: Mac Pro (Mid 2010) and Google Compute Engine(GCE) \cite{GCE}. 

1. Mac Pro (Mid 2010) has one 2.8GHz Quad-Core Intel Xeon with 16GB memories and ATI Radeon HD 5770 with 1024MB memories. 

2. Our GCE settings include as follows:
	* Machine type: custom (8 vCPUs and 16GB memories)
	* CPU platform: Intel Broadwell
	* GPU: one NVIDIA Tesla K80
	* Zone: us-west1-b

The version of OpenCL \cite{OpenCL} is 1.2.

## Evaluation Result

Table \ref{result} shows the result of the benchmarks. 

\begin{table*}[]
\centering
\caption{The result of the benchmarks}
\label{result}
\begin{tabular}{lll|r|r|}
           &                  &              & \multicolumn{1}{l|}{Mac Pro (Mid 2010)} & \multicolumn{1}{l|}{GCE}              \\
           &                  &              & \multicolumn{1}{l|}{2.8GHz Quad-Core Intel Xeon} & \multicolumn{1}{l|}{Intel Broadwell vCPU:8}           \\
           &                  &              & \multicolumn{1}{l|}{ATI Radeon HD 5770} & \multicolumn{1}{l|}{NVIDIA Tesla K80} \\ \hline
benchmark1 & pure Elixir      & loop         & 12.80              & 9.537            \\
benchmark3 & pure Elixir      & inlining     & 11.57              & 8.020            \\
benchmark8 & Elixir / Rustler & CPU          & 9.703              & 7.908            \\
\rowcolor[HTML]{C0C0C0} 
benchmark9 & Elixir / Rustler & OpenCL (GPU) & 6.572              & 4.494            \\
empty      & Elixir / Rustler & empty        & 6.027              & 4.022            \\
Rust\_CPU  & pure Rust        & CPU          & 2.721              & 1.723            \\
\rowcolor[HTML]{C0C0C0} 
Rust\_GPU  & pure Rust        & OpenCL (GPU) & 1.857              & 0.7942           \\
Python     & Python           & NumPy (CPU)  & 17.75              & N/A          
\end{tabular}
\end{table*}
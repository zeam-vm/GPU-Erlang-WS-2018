# Introduction


* GPGPU \cite{Nickolls:2008:SPP:1401132.1401152}

* Our previous work \cite{ZACKY18}

* Elixir \cite{Elixir16}
* TensorFlow \cite{TensorFlow}, Keras \cite{Keras} 
* Logistic Maps \cite{Miyazaki14}


\begin{table*}[]
\centering
\caption{The result of the benchmarks}
\label{result}
\begin{tabular}{lll|l|l}
           &                  &              & Mac Pro 2010       & GCE              \\
           &                  &              & vCPU:4             & vCPU:8           \\
           &                  &              & ATI Radeon HD 5770 & NVIDIA Tesla K80 \\ \hline
benchmark1 & pure Elixir      & loop         & 12.80              & 9.537            \\
benchmark3 & pure Elixir      & inlining     & 11.57              & 8.020            \\
benchmark8 & Elixir / Rustler & CPU          & 9.703              & 7.908            \\
\rowcolor[HTML]{C0C0C0} 
benchmark9 & Elixir / Rustler & OpenCL (GPU) & 6.572              & 4.494            \\
empty      & Elixir / Rustler & empty        & 6.027              & 4.022            \\
Rust\_CPU  & pure Rust        & CPU          & 2.721              & 1.723            \\
\rowcolor[HTML]{C0C0C0} 
Rust\_GPU  & pure Rust        & OpenCL (GPU) & 1.857              & 0.7942          
\end{tabular}
\end{table*}
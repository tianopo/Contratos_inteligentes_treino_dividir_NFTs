import React, { useEffect, useState } from 'react';
const ethers = require("ethers");
import Web3Modal from "web3modal";
import WalletConnectProvider from "@walletconnect/web3-provider";

export default function Home() {
  const contractAddress = process.env.CONTRACT_ADDRESS;
  const abi = process.env.ABI;

  const [provider, setProvider] = useState<any>();
  const [storedNumber, setStoredNumber] = useState<number>();
  const [enteredNumber, setEnteredNumber] = useState<number>(0);
  const [storeLoader, setStoreLoader] = useState<boolean>(false);
  const [retrieveLoader, setRetrieveLoader] = useState<boolean>(false);

  async function initWallet() {
    try {
      if (typeof window.ethereum === 'undefined') {
        console.log("Please install wallet.");
        alert("Please install wallet.");
        return;
      } else {
        const web3ModalVar = new Web3Modal({
          cacheProvider: true,
          providerOptions: {
            walletconnect: {
              package: WalletConnectProvider,
            },
          },
        });
        
        const instanceVar: any = await web3ModalVar.connect();
        const providerVar = new ethers.providers.Web3Provider(instanceVar);
        setProvider(providerVar);
        readNumber(providerVar);
        return;
      }
    } catch (error) {
      console.log(error);
      return;
    }
  }

  async function readNumber(provider) {
    try {
      setRetrieveLoader(true);
      const signer = provider.getSigner();
      const smartContract = new ethers.Contract(contractAddress, abi, provider);
      const contractWithSigner = smartContract.connect(signer);
      const response = await contractWithSigner.readNum();
      console.log(parseInt(response));
      setStoredNumber(parseInt(response));
      setRetrieveLoader(false);
      return;
    } catch (error) {
      alert(error);
      setRetrieveLoader(false);
      return;
    }
  }
  
  async function writeNumber() {
    try {
      setStoreLoader(true);
      const signer = provider!.getSigner();
      const smartContract = new ethers.Contract(contractAddress, abi, provider!);
      const contractWithSigner = smartContract.connect(signer);
      const writeNumTX = await contractWithSigner.writeNum(enteredNumber);
      const response = await writeNumTX.wait();
      console.log(await response);
      setStoreLoader(false);
      alert(`Number stored successfully ${enteredNumber}`);
      return;
    } catch (error) {
      alert(error);
      setStoreLoader(false);
      return;
    }
  }

  useEffect(() => {
    initWallet();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
  

  return (
    <div className='m-6 space-y-4'>
      <h1 className="text-gray-700 text-3xl font-bold">
        Storage Frontend Demo
      </h1>

      <h3>This action retrieves the saved number from smart contract. (i.e Read Operation)</h3>
      <button className='px-4 py-1 bg-slate-300 hover:bg-slate-500 flex justify-around transition-all w-32' onClick={()=>readNumber(provider)}> { retrieveLoader ? (
                  <svg
                    className="animate-spin m-1 h-5 w-5 text-white"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75 text-gray-700"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
              ): "RETRIEVE"} </button>
      <h4>The stored number is <span className='font-bold'>{storedNumber ? storedNumber : 0}</span> </h4>
      <hr></hr>

      <h3>This action saves entered number into the smart contract. (i.e Write Operation) </h3>
      <div>
        <input onChange={(e)=>{
          setEnteredNumber(parseInt(e.target.value));
        }} className="placeholder:italic transition-all placeholder:text-gray-500 w-4/6 border border-gray-500 rounded-md p-2 shadow-sm focus:outline-none focus:border-sky-500 focus:ring-sky-500 focus:ring-1 sm:text-sm" placeholder="Enter a number to store" type="text" name="store"/>
      </div>
      <button onClick={writeNumber} className='px-4 py-1 bg-slate-300 flex justify-around hover:bg-slate-500 transition-all w-32'> { storeLoader ? (
                  <svg
                    className="animate-spin m-1 h-5 w-5 text-white"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75 text-gray-700"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
              ): "STORE"} </button>


    </div>
  )
}
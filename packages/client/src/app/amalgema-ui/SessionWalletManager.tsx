import { formatEther, parseEther } from "viem";
import { LabeledOrbInput, ReadOnlyTextInput } from "./SummonIsland/common";
import { LOW_BALANCE_THRESHOLD, useBurnerBalance } from "./hooks/useBurnerBalance";
import { Button } from "../ui/Theme/SkyStrife/Button";
import { Modal } from "./Modal";
import { useAmalgema } from "../../useAmalgema";
import { useMainWalletBalance } from "./hooks/useMainWalletBalance";
import { Body } from "../ui/Theme/SkyStrife/Typography";
import { PromiseButton } from "../ui/hooks/PromiseButton";
import { useState } from "react";
import { twMerge } from "tailwind-merge";

function WarningSvg() {
  return (
    <svg width="80" height="80" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M12.0001 8.99999V12.75M2.69707 16.126C1.83107 17.626 2.91407 19.5 4.64507 19.5H19.3551C21.0851 19.5 22.1681 17.626 21.3031 16.126L13.9491 3.37799C13.0831 1.87799 10.9171 1.87799 10.0511 3.37799L2.69707 16.126ZM12.0001 15.75H12.0071V15.758H12.0001V15.75Z"
        stroke="#BF1818"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function LowBalanceWarning() {
  return (
    <div
      style={{
        borderRadius: "2px",
        border: "1px solid #BF1818",
        background: "#FFECEB",
        boxShadow: "2px 2px 0px 0px rgba(24, 23, 16, 0.90)",
      }}
      className="flex flex-row space-x-2 p-3"
    >
      <WarningSvg />
      <div>
        <div>
          <div className="text-[#BF1818] font-medium">Session wallet running low</div>
        </div>
        <Body className="text-ss-text-default">
          Your session wallet balance is below the recommended minimum of 0.001 ETH. Top up now or you will not be able
          to play matches!
        </Body>
      </div>
    </div>
  );
}

export function SessionWalletManager() {
  const {
    externalWalletClient,
    network: { walletClient },
  } = useAmalgema();

  const mainWalletAddress = externalWalletClient?.account?.address ?? "0x00";
  const burnerWalletAddress = walletClient.account.address;

  const burnerBalance = useBurnerBalance();
  const mainWalletBalance = useMainWalletBalance();

  const [transferAmount, setTransferAmount] = useState<number | null>(0);

  return (
    <>
      <div>
        <LabeledOrbInput
          amount={parseFloat(parseFloat(formatEther(burnerBalance?.value || 0n)).toFixed(6))}
          className="pr-2"
          label="Session Wallet Balance"
          symbol="ETH"
        />

        {burnerBalance?.belowMinimum && (
          <>
            <div className="h-2" />
            <LowBalanceWarning />
          </>
        )}

        <div className="h-3" />

        <Modal
          title="Manage Session Wallet"
          trigger={
            <Button buttonType={burnerBalance?.belowMinimum ? "secondary" : "tertiary"} className="w-full">
              {burnerBalance?.belowMinimum ? "transfer to session wallet" : "Manage session wallet"}
            </Button>
          }
        >
          <ReadOnlyTextInput value={burnerWalletAddress} className="pr-2 text-right" label="Session Wallet" />

          <div className="h-3" />

          <ReadOnlyTextInput value={mainWalletAddress} className="pr-2 text-right" label="Main Wallet" />

          <div className="h-8" />

          <Body className="text-ss-text-default">
            For your security, matches of Sky Strife use a <strong>temporary session wallet</strong> — stored in local
            storage — with a small amount of funds instead of your primary wallet. It will be used for every action you
            make during the match.
            <br></br>
            <br></br>
            We recommend storing <strong>about 0.001 ETH in your match wallet at all times</strong> — the amount
            required to safely be able to complete five average matches of Sky Strife.
          </Body>

          <div className="h-8" />

          <div className="flex flex-row space-x-6">
            <LabeledOrbInput
              amount={parseFloat(parseFloat(formatEther(burnerBalance?.value || 0n)).toFixed(6))}
              className="pr-2"
              label="Session Wallet"
              symbol="ETH"
            />
            <LabeledOrbInput
              amount={parseFloat(parseFloat(formatEther(mainWalletBalance?.value || 0n)).toFixed(6))}
              className="pr-2"
              label="Main Wallet"
              symbol="ETH"
            />
          </div>

          {burnerBalance?.belowMinimum && (
            <>
              <div className="h-3" />
              <LowBalanceWarning />
            </>
          )}

          <div className="h-4" />

          <PromiseButton
            promise={async () => {
              if (!externalWalletClient || !externalWalletClient.account) {
                throw new Error("No external wallet connected");
              }

              await externalWalletClient.sendTransaction({
                chain: walletClient.chain,
                account: externalWalletClient.account,
                to: walletClient.account.address,
                value: parseEther("0.001"),
              });
            }}
            disabled={!burnerBalance?.belowMinimum || (mainWalletBalance?.value ?? 0n) < LOW_BALANCE_THRESHOLD}
            className="w-full"
            buttonType="primary"
          >
            top up session wallet
          </PromiseButton>

          <div className="h-3" />

          <div className="mx-auto w-fit text-ss-text-x-light">or</div>

          <div className="h-3" />

          <div className="flex space-x-3 mb-[-64px]">
            <div className="grow flex items-center space-x-2">
              <input
                className={twMerge("w-full bg-white px-4 py-2 border border-[#DDDAD0] grow")}
                type="number"
                placeholder="Transfer custom amount"
                value={transferAmount ?? ""}
                min={0}
                onChange={(e) => {
                  const n = parseFloat(e.target.value);
                  if (isNaN(n)) {
                    setTransferAmount(null);
                    return;
                  }

                  setTransferAmount(n);
                }}
              />

              <div className="">ETH</div>
            </div>

            <PromiseButton
              promise={async () => {
                if (!externalWalletClient || !externalWalletClient.account) {
                  throw new Error("No external wallet connected");
                }

                await externalWalletClient.sendTransaction({
                  chain: walletClient.chain,
                  account: externalWalletClient.account,
                  to: walletClient.account.address,
                  value: parseEther((transferAmount ?? 0).toString()),
                });
              }}
              buttonType="secondary"
              disabled={
                (transferAmount ?? 0) <= 0 ||
                (mainWalletBalance?.value ?? 0n) < parseEther((transferAmount ?? 0).toString())
              }
            >
              transfer
            </PromiseButton>
          </div>
        </Modal>
      </div>
    </>
  );
}

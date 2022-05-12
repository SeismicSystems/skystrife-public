import { useMatchInfo } from "../hooks/useMatchInfo";
import { useAllPlayerDetails } from "../hooks/usePlayerDetails";
import { Card } from "../Theme/SkyStrife/Card";
import { ClickWrapper } from "../Theme/ClickWrapper";
import { PlayerCard } from "./PlayerCard";
import { Entity } from "@latticexyz/recs";
import { useMatchStarted } from "../hooks/useMatchStarted";

export const Leaderboard = ({ matchEntity }: { matchEntity: Entity }) => {
  const playerData = useAllPlayerDetails(matchEntity);

  const matchStarted = useMatchStarted(matchEntity);
  const { matchFinished } = useMatchInfo(matchEntity);
  if (!matchStarted || matchFinished) return <></>;

  return (
    <div className="absolute flex h-fit w-[340px] flex-col items-center">
      <Card primary className="p-2 border-[#181710]">
        <ClickWrapper>
          <ul
            style={{
              width: "100%",
              padding: "8px",
            }}
          >
            <li className="flex flex-row gap-2.5 text-xs uppercase tracking-wider text-ss-text-x-light mb-2">
              <div className="w-[120px] grow-0">player</div>
              <div className="grow basis-1">army size</div>
              <div className="grow basis-1">gold/turn</div>
            </li>

            {playerData.length === 0 && (
              <li className="flex flex-row gap-2.5 text-xs">
                <div className="w-[120px] grow-0">n/a</div>
                <div className="grow basis-1">-</div>
                <div className="grow basis-1">-</div>
              </li>
            )}

            {playerData.map((player) => {
              if (!player) return <li></li>;

              return <PlayerCard key={`${player.player}`} playerData={player} />;
            })}
          </ul>
        </ClickWrapper>
      </Card>
    </div>
  );
};

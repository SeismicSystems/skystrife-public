import { defineSystem, getComponentValue, Has, Not, UpdateType } from "@latticexyz/recs";
import { PhaserLayer } from "../../types";

/**
 * The Appearance system handles setting textures of phaser game objects based on their Appearance component
 */
export function createAppearanceSystem(layer: PhaserLayer) {
  const {
    world,
    components: { Appearance },
    scenes: {
      Main: { objectPool, config },
    },
    parentLayers: {
      local: {
        components: { LocalPosition },
      },
      network: {
        components: { StructureType },
      },
    },
  } = layer;

  defineSystem(world, [Has(Appearance), Has(LocalPosition), Not(StructureType)], (update) => {
    const { entity, type } = update;

    if (type === UpdateType.Enter) {
      const appearance = getComponentValue(Appearance, entity);
      if (!appearance) return;
      const sprite = config.sprites[appearance.value as 0];
      const embodiedEntity = objectPool.get(entity, "Sprite");

      embodiedEntity.setComponent({
        id: Appearance.id,
        once: (gameObject) => {
          gameObject.setTexture(sprite.assetKey, sprite.frame);
        },
      });
    }
  });

  defineSystem(world, [Has(Appearance), Has(LocalPosition), Has(StructureType)], (update) => {
    const { entity, type } = update;

    if (type === UpdateType.Enter || type === UpdateType.Update) {
      const appearance = getComponentValue(Appearance, entity);
      if (!appearance) return;
      const sprite = config.sprites[appearance.value as 0];
      const embodiedEntity = objectPool.get(entity, "Sprite");

      embodiedEntity.setComponent({
        id: Appearance.id,
        once: (gameObject) => {
          gameObject.setTexture(sprite.assetKey, sprite.frame);
        },
      });
    }
  });
}

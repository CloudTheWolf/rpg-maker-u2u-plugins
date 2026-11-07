# Recovered API name index

Generated from this demo's IL2CPP metadata. See `reference.json` for source hashes.

Every entry below is **a recovered name**, not a verified callable signature. Arguments, return values, availability and side effects remain unknown unless the guide explicitly documents them. Do not append guessed arguments to these names.

`L123` means literal index 123 in this build's metadata. Identical text is deduplicated by IL2CPP; a literal can be shared by multiple methods.

Recovered 329 public `ctx` names in 27 groups.

## ctx.action

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.action.create` | L20173 | ctx.action.create (no active battle) |
| `ctx.action.enqueue` | L20175 | ctx.action.enqueue (no active battle) |
| `ctx.action.get` | L20177 | No method-specific context diagnostic recovered. |

## ctx.actor

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.actor.addParam` | L20178 | ctx.actor.addParam (actor progress state not integrated) |
| `ctx.actor.addState` | L20180 | ctx.actor.addState (actor state not integrated) |
| `ctx.actor.changeClass` | L20182 | ctx.actor.changeClass (actor progress state not integrated) |
| `ctx.actor.forgetSkill` | L20184 | ctx.actor.forgetSkill (actor progress state not integrated) |
| `ctx.actor.gainHp` | L20186 | ctx.actor.gainHp (actor progress state not integrated) |
| `ctx.actor.gainMp` | L20188 | ctx.actor.gainMp (actor progress state not integrated) |
| `ctx.actor.gainTp` | L20190 | ctx.actor.gainTp (actor progress state not integrated) |
| `ctx.actor.getClassId` | L20192 | No method-specific context diagnostic recovered. |
| `ctx.actor.getLevelUpMessages` | L20193 | No method-specific context diagnostic recovered. |
| `ctx.actor.getName` | L20194 | No method-specific context diagnostic recovered. |
| `ctx.actor.getSkills` | L20195 | No method-specific context diagnostic recovered. |
| `ctx.actor.getStates` | L20196 | No method-specific context diagnostic recovered. |
| `ctx.actor.hasSkill` | L20197 | No method-specific context diagnostic recovered. |
| `ctx.actor.learnSkill` | L20198 | ctx.actor.learnSkill (actor progress state not integrated) |
| `ctx.actor.recoverAll` | L20200 | ctx.actor.recoverAll (actor state not integrated) |
| `ctx.actor.removeState` | L20202 | ctx.actor.removeState (actor state not integrated) |
| `ctx.actor.setImages` | L20204 | ctx.actor.setImages (actor image state not integrated) |
| `ctx.actor.setName` | L20206 | ctx.actor.setName (actor text state not integrated) |
| `ctx.actor.setNickname` | L20208 | ctx.actor.setNickname (actor text state not integrated) |
| `ctx.actor.setProfile` | L20210 | ctx.actor.setProfile (actor text state not integrated) |

## ctx.audio

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.audio.fadeoutBgm` | L20212 | ctx.audio.fadeoutBgm (audio runtime not bound) |
| `ctx.audio.fadeoutBgs` | L20214 | ctx.audio.fadeoutBgs (audio runtime not bound) |
| `ctx.audio.playBgm` | L20216 | ctx.audio.playBgm (audio runtime not bound) |
| `ctx.audio.playBgs` | L20218 | ctx.audio.playBgs (audio runtime not bound) |
| `ctx.audio.playMe` | L20220 | ctx.audio.playMe (audio runtime not bound) |
| `ctx.audio.playSe` | L20222 | ctx.audio.playSe (audio runtime not bound) |
| `ctx.audio.resumeBgm` | L20224 | ctx.audio.resumeBgm (audio runtime not bound) |
| `ctx.audio.saveBgm` | L20226 | ctx.audio.saveBgm (audio runtime not bound) |
| `ctx.audio.setBattleBgm` | L20228 | ctx.audio.setBattleBgm (audio runtime not bound) |
| `ctx.audio.setDefeatMe` | L20230 | ctx.audio.setDefeatMe (audio runtime not bound) |
| `ctx.audio.setVictoryMe` | L20232 | ctx.audio.setVictoryMe (audio runtime not bound) |
| `ctx.audio.stopSe` | L20234 | ctx.audio.stopSe (audio runtime not bound) |

## ctx.battle

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.battle.abort` | L20236 | ctx.battle.abort (no active battle) |
| `ctx.battle.advancePhase` | L20238 | ctx.battle.advancePhase (no active battle) |
| `ctx.battle.appearEnemy` | L20240 | No method-specific context diagnostic recovered. |
| `ctx.battle.changeBattleback` | L20241 | No method-specific context diagnostic recovered. |
| `ctx.battle.getActionOrder` | L20242 | No method-specific context diagnostic recovered. |
| `ctx.battle.getCommonEvent` | L20243 | No method-specific context diagnostic recovered. |
| `ctx.battle.getItemInfo` | L20244 | ctx.battle.getItemInfo (item info seam not wired) |
| `ctx.battle.getMembers` | L20246 | No method-specific context diagnostic recovered. |
| `ctx.battle.getPhase` | L20247 | No method-specific context diagnostic recovered. |
| `ctx.battle.getQueued` | L20248 | No method-specific context diagnostic recovered. |
| `ctx.battle.getResult` | L20249 | No method-specific context diagnostic recovered. |
| `ctx.battle.getRewards` | L20250 | No method-specific context diagnostic recovered. |
| `ctx.battle.getSkillInfo` | L20251 | ctx.battle.getSkillInfo (skill info seam not wired) |
| `ctx.battle.getStartAdvantage` | L20253 | No method-specific context diagnostic recovered. |
| `ctx.battle.getStateInfo` | L20254 | ctx.battle.getStateInfo (state info seam not wired) |
| `ctx.battle.getTroopPages` | L20256 | No method-specific context diagnostic recovered. |
| `ctx.battle.getTurn` | L20257 | No method-specific context diagnostic recovered. |
| `ctx.battle.isFastForward` | L20258 | No method-specific context diagnostic recovered. |
| `ctx.battle.isLogBusy` | L20259 | No method-specific context diagnostic recovered. |
| `ctx.battle.isStartMessagePending` | L20260 | No method-specific context diagnostic recovered. |
| `ctx.battle.judge` | L20261 | ctx.battle.judge (no active battle) |
| `ctx.battle.logEventTrace` | L20263 | No method-specific context diagnostic recovered. |
| `ctx.battle.nextRandom` | L20264 | ctx.battle.nextRandom (no active battle) |
| `ctx.battle.pushLog` | L20266 | No method-specific context diagnostic recovered. |
| `ctx.battle.requestEscape` | L20267 | ctx.battle.requestEscape (no active battle) |
| `ctx.battle.setFlow` | L20269 | No method-specific context diagnostic recovered. |
| `ctx.battle.startEncounter` | L20270 | ctx.battle.startEncounter (host not bound) |
| `ctx.battle.transformEnemy` | L20272 | No method-specific context diagnostic recovered. |

## ctx.battler

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.battler.addParam` | L20273 | ctx.battler.addParam (battle store not integrated) |
| `ctx.battler.addState` | L20275 | ctx.battler.addState (no active battle) |
| `ctx.battler.applyDamage` | L20277 | ctx.battler.applyDamage (no active battle) |
| `ctx.battler.applyMpDamage` | L20279 | ctx.battler.applyMpDamage (no active battle) |
| `ctx.battler.gainTp` | L20281 | ctx.battler.gainTp (no active battle) |
| `ctx.battler.getInfo` | L20283 | No method-specific context diagnostic recovered. |
| `ctx.battler.getParam` | L20284 | No method-specific context diagnostic recovered. |
| `ctx.battler.getStates` | L20285 | No method-specific context diagnostic recovered. |
| `ctx.battler.getTraits` | L20286 | No method-specific context diagnostic recovered. |
| `ctx.battler.removeState` | L20287 | ctx.battler.removeState (no active battle) |
| `ctx.battler.setGuard` | L20289 | ctx.battler.setGuard (no active battle) |

## ctx.command

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.command.advance` | L20293 | No method-specific context diagnostic recovered. |
| `ctx.command.branch` | L20294 | No method-specific context diagnostic recovered. |
| `ctx.command.breakLoop` | L20295 | ctx.command.breakLoop (no active event) |
| `ctx.command.callCommonEvent` | L20297 | ctx.command.callCommonEvent (no active event) |
| `ctx.command.clearChoiceBranch` | L20299 | No method-specific context diagnostic recovered. |
| `ctx.command.current` | L20300 | No method-specific context diagnostic recovered. |
| `ctx.command.endFrameWait` | L20301 | No method-specific context diagnostic recovered. |
| `ctx.command.exitList` | L20302 | ctx.command.exitList (no active event) |
| `ctx.command.finish` | L20304 | No method-specific context diagnostic recovered. |
| `ctx.command.frameWaitRemaining` | L20305 | No method-specific context diagnostic recovered. |
| `ctx.command.frameWaiting` | L20306 | No method-specific context diagnostic recovered. |
| `ctx.command.getChoiceBranch` | L20307 | No method-specific context diagnostic recovered. |
| `ctx.command.getEventUid` | L20308 | No method-specific context diagnostic recovered. |
| `ctx.command.isOnCurrentMap` | L20309 | No method-specific context diagnostic recovered. |
| `ctx.command.jumpToLabel` | L20310 | ctx.command.jumpToLabel (no active event) |
| `ctx.command.repeatLoop` | L20312 | ctx.command.repeatLoop (no active event) |
| `ctx.command.reserveCommonEvent` | L20314 | No method-specific context diagnostic recovered. |
| `ctx.command.setChoiceBranch` | L20315 | No method-specific context diagnostic recovered. |
| `ctx.command.startFrameWait` | L20316 | ctx.command.startFrameWait (no active event) |
| `ctx.command.yieldFrame` | L20318 | ctx.command.yieldFrame (no active event) |

## ctx.config

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.config.get` | L20320 | No method-specific context diagnostic recovered. |
| `ctx.config.registerOption` | L20321 | No method-specific context diagnostic recovered. |
| `ctx.config.set` | L20322 | No method-specific context diagnostic recovered. |

## ctx.db

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.db.count` | L20323 | No method-specific context diagnostic recovered. |
| `ctx.db.getActor` | L20324 | No method-specific context diagnostic recovered. |
| `ctx.db.getArmor` | L20325 | No method-specific context diagnostic recovered. |
| `ctx.db.getClass` | L20326 | No method-specific context diagnostic recovered. |
| `ctx.db.getCommonEvent` | L20327 | No method-specific context diagnostic recovered. |
| `ctx.db.getCustom` | L20328 | No method-specific context diagnostic recovered. |
| `ctx.db.getEnemy` | L20329 | No method-specific context diagnostic recovered. |
| `ctx.db.getItem` | L20330 | No method-specific context diagnostic recovered. |
| `ctx.db.getSkill` | L20331 | No method-specific context diagnostic recovered. |
| `ctx.db.getState` | L20332 | No method-specific context diagnostic recovered. |
| `ctx.db.getSystem` | L20333 | No method-specific context diagnostic recovered. |
| `ctx.db.getTroop` | L20334 | No method-specific context diagnostic recovered. |
| `ctx.db.getWeapon` | L20335 | No method-specific context diagnostic recovered. |
| `ctx.db.listCustom` | L20336 | No method-specific context diagnostic recovered. |

## ctx.editor

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.editor.beginUndoGroup` | L20339 | No method-specific context diagnostic recovered. |
| `ctx.editor.checkLuau` | L20340 | No method-specific context diagnostic recovered. |
| `ctx.editor.endUndoGroup` | L20341 | No method-specific context diagnostic recovered. |
| `ctx.editor.getCurrentMap` | L20342 | No method-specific context diagnostic recovered. |
| `ctx.editor.getMapInfo` | L20343 | No method-specific context diagnostic recovered. |
| `ctx.editor.getSelection` | L20344 | No method-specific context diagnostic recovered. |
| `ctx.editor.listMaps` | L20345 | No method-specific context diagnostic recovered. |
| `ctx.editor.listParts` | L20346 | No method-specific context diagnostic recovered. |
| `ctx.editor.listPresets` | L20347 | No method-specific context diagnostic recovered. |
| `ctx.editor.log` | L20348 | No method-specific context diagnostic recovered. |
| `ctx.editor.openMap` | L20349 | No method-specific context diagnostic recovered. |
| `ctx.editor.paintGround` | L20350 | No method-specific context diagnostic recovered. |
| `ctx.editor.paintGroundCells` | L20351 | No method-specific context diagnostic recovered. |
| `ctx.editor.paintGroundRect` | L20352 | No method-specific context diagnostic recovered. |
| `ctx.editor.placePart` | L20353 | No method-specific context diagnostic recovered. |
| `ctx.editor.placeParts` | L20354 | No method-specific context diagnostic recovered. |
| `ctx.editor.removePart` | L20355 | No method-specific context diagnostic recovered. |
| `ctx.editor.setPartFlags` | L20356 | No method-specific context diagnostic recovered. |
| `ctx.editor.setPartSubTileOffset` | L20357 | No method-specific context diagnostic recovered. |

## ctx.effect

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.effect.beginBattlerMotion` | L20358 | No method-specific context diagnostic recovered. |
| `ctx.effect.beginBattlerMove` | L20359 | No method-specific context diagnostic recovered. |
| `ctx.effect.isBattleAnimationPlaying` | L20360 | No method-specific context diagnostic recovered. |
| `ctx.effect.isBattlerMoving` | L20361 | No method-specific context diagnostic recovered. |
| `ctx.effect.isMotionPlaying` | L20362 | No method-specific context diagnostic recovered. |
| `ctx.effect.showAnimation` | L20363 | ctx.effect.showAnimation (effect runtime not bound) |
| `ctx.effect.showBalloon` | L20365 | ctx.effect.showBalloon (effect runtime not bound) |
| `ctx.effect.showBattleAnimation` | L20367 | No method-specific context diagnostic recovered. |

## ctx.event

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.event.callEvent` | L20368 | ctx.event.callEvent (event runtime not bound) |
| `ctx.event.despawn` | L20370 | ctx.event.despawn (event runtime not bound) |
| `ctx.event.erase` | L20372 | ctx.event.erase (event runtime not bound) |
| `ctx.event.findPlacement` | L20374 | No method-specific context diagnostic recovered. |
| `ctx.event.getInfo` | L20375 | No method-specific context diagnostic recovered. |
| `ctx.event.getSelfVar` | L20376 | No method-specific context diagnostic recovered. |
| `ctx.event.setControlled` | L20377 | ctx.event.setControlled (event runtime not bound) |
| `ctx.event.setDirection` | L20379 | ctx.event.setDirection (event runtime not bound) |
| `ctx.event.setPosition` | L20381 | ctx.event.setPosition (event runtime not bound) |
| `ctx.event.setSelfVar` | L20383 | ctx.event.setSelfVar (event runtime not bound) |
| `ctx.event.setVisible` | L20385 | ctx.event.setVisible (event runtime not bound) |
| `ctx.event.spawn` | L20387 | ctx.event.spawn (event runtime not bound) |
| `ctx.event.step` | L20389 | ctx.event.step (event runtime not bound) |

## ctx.game

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.game.evalLuau` | L20391 | ctx.game.evalLuau (game state not integrated) |
| `ctx.game.evaluateCondition` | L20393 | No method-specific context diagnostic recovered. |
| `ctx.game.evaluateScript` | L20394 | ctx.game.evaluateScript (game state not integrated) |
| `ctx.game.getActorParam` | L20396 | ctx.game.getActorParam (game state not integrated) |
| `ctx.game.getLastActionData` | L20398 | No method-specific context diagnostic recovered. |
| `ctx.game.getSelfSwitch` | L20399 | No method-specific context diagnostic recovered. |
| `ctx.game.getStat` | L20400 | ctx.game.getStat (game state not integrated) |
| `ctx.game.getSwitch` | L20402 | ctx.game.getSwitch (game state not integrated) |
| `ctx.game.getTimerSeconds` | L20404 | ctx.game.getTimerSeconds (game state not integrated) |
| `ctx.game.getVariable` | L20406 | ctx.game.getVariable (game state not integrated) |
| `ctx.game.isTimerRunning` | L20408 | ctx.game.isTimerRunning (game state not integrated) |
| `ctx.game.random` | L20410 | ctx.game.random (game state not integrated); ctx.game.random is not allowed inside a script operand expression |
| `ctx.game.runScript` | L20413 | ctx.game.runScript (game state not integrated) |
| `ctx.game.setEncounterEnabled` | L20415 | ctx.game.setEncounterEnabled (system flags not integrated) |
| `ctx.game.setFormationEnabled` | L20417 | ctx.game.setFormationEnabled (system flags not integrated) |
| `ctx.game.setLastActionData` | L20419 | No method-specific context diagnostic recovered. |
| `ctx.game.setMenuEnabled` | L20420 | ctx.game.setMenuEnabled (system flags not integrated) |
| `ctx.game.setSaveEnabled` | L20422 | ctx.game.setSaveEnabled (system flags not integrated) |
| `ctx.game.setSelfSwitch` | L20424 | ctx.game.setSelfSwitch (game state not integrated) |
| `ctx.game.setSwitch` | L20426 | ctx.game.setSwitch (game state not integrated) |
| `ctx.game.setVariable` | L20428 | ctx.game.setVariable (game state not integrated) |
| `ctx.game.setWindowTone` | L20430 | ctx.game.setWindowTone (system flags not integrated) |
| `ctx.game.startTimer` | L20432 | ctx.game.startTimer (game state not integrated) |
| `ctx.game.stopTimer` | L20434 | ctx.game.stopTimer (game state not integrated) |

## ctx.i18n

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.i18n.baseLocale` | L20436 | No method-specific context diagnostic recovered. |
| `ctx.i18n.locale` | L20437 | No method-specific context diagnostic recovered. |
| `ctx.i18n.locales` | L20438 | No method-specific context diagnostic recovered. |
| `ctx.i18n.setLocale` | L20439 | No method-specific context diagnostic recovered. |
| `ctx.i18n.table` | L20440 | No method-specific context diagnostic recovered. |

## ctx.input

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.input.getKey` | L20444 | No method-specific context diagnostic recovered. |
| `ctx.input.getKeyDown` | L20445 | No method-specific context diagnostic recovered. |
| `ctx.input.isButton` | L20446 | No method-specific context diagnostic recovered. |
| `ctx.input.poll` | L20447 | No method-specific context diagnostic recovered. |

## ctx.inventory

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.inventory.enumerateItemIds` | L20448 | No method-specific context diagnostic recovered. |
| `ctx.inventory.gainArmor` | L20450 | ctx.inventory.gainArmor (inventory state not integrated) |
| `ctx.inventory.gainItem` | L20452 | ctx.inventory.gainItem (inventory state not integrated) |
| `ctx.inventory.gainWeapon` | L20454 | ctx.inventory.gainWeapon (inventory state not integrated) |
| `ctx.inventory.getArmorCount` | L20456 | ctx.inventory.getArmorCount (inventory state not integrated) |
| `ctx.inventory.getItemCount` | L20458 | ctx.inventory.getItemCount (inventory state not integrated) |
| `ctx.inventory.getWeaponCount` | L20460 | ctx.inventory.getWeaponCount (inventory state not integrated) |

## ctx.manifest

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.manifest.getCommandDef` | L20462 | No method-specific context diagnostic recovered. |
| `ctx.manifest.getManifest` | L20463 | No method-specific context diagnostic recovered. |

## ctx.map

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.map.changeParallax` | L20464 | ctx.map.changeParallax (no map loaded) |
| `ctx.map.changeTilesetFamily` | L20466 | ctx.map.changeTilesetFamily (no map loaded) |
| `ctx.map.forceMoveRoute` | L20468 | No method-specific context diagnostic recovered. |
| `ctx.map.getCurrentMap` | L20469 | No method-specific context diagnostic recovered. |
| `ctx.map.getEvent` | L20470 | No method-specific context diagnostic recovered. |
| `ctx.map.getLocationInfo` | L20471 | No method-specific context diagnostic recovered. |
| `ctx.map.getOnOffVehicle` | L20472 | No method-specific context diagnostic recovered. |
| `ctx.map.getPassability` | L20473 | ctx.map.getPassability (no map loaded) |
| `ctx.map.requestTransfer` | L20475 | No method-specific context diagnostic recovered. |
| `ctx.map.resolveMapGuid` | L20476 | No method-specific context diagnostic recovered. |
| `ctx.map.resolveMapId` | L20477 | No method-specific context diagnostic recovered. |
| `ctx.map.setEventLocation` | L20478 | No method-specific context diagnostic recovered. |
| `ctx.map.setNameDisplay` | L20479 | No method-specific context diagnostic recovered. |
| `ctx.map.setVehicleBgm` | L20480 | ctx.map.setVehicleBgm (vehicles not integrated) |
| `ctx.map.setVehicleImage` | L20482 | ctx.map.setVehicleImage (vehicles not integrated) |
| `ctx.map.setVehicleLocation` | L20484 | ctx.map.setVehicleLocation (vehicles not integrated) |
| `ctx.map.swapEventLocation` | L20486 | No method-specific context diagnostic recovered. |

## ctx.meta

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.meta.get` | L20487 | No method-specific context diagnostic recovered. |
| `ctx.meta.has` | L20488 | No method-specific context diagnostic recovered. |
| `ctx.meta.list` | L20489 | No method-specific context diagnostic recovered. |

## ctx.parameter

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.parameter.get` | L20490 | No method-specific context diagnostic recovered. |
| `ctx.parameter.getDefault` | L20491 | No method-specific context diagnostic recovered. |

## ctx.party

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.party.addExp` | L20492 | ctx.party.addExp (party state not integrated) |
| `ctx.party.addGold` | L20494 | ctx.party.addGold (party state not integrated) |
| `ctx.party.changeEquip` | L20496 | ctx.party.changeEquip (party state not integrated) |
| `ctx.party.changeMember` | L20498 | ctx.party.changeMember (party state not integrated) |
| `ctx.party.gainExp` | L20500 | ctx.party.gainExp (party state not integrated) |
| `ctx.party.gainGold` | L20502 | ctx.party.gainGold (party state not integrated) |
| `ctx.party.getActorExp` | L20504 | ctx.party.getActorExp (party state not integrated) |
| `ctx.party.getActorLevel` | L20506 | ctx.party.getActorLevel (party state not integrated) |
| `ctx.party.getActorMaxLevel` | L20508 | No method-specific context diagnostic recovered. |
| `ctx.party.getEquips` | L20509 | ctx.party.getEquips (party state not integrated) |
| `ctx.party.getGold` | L20511 | ctx.party.getGold (party state not integrated) |
| `ctx.party.getMembers` | L20513 | ctx.party.getMembers (party state not integrated) |
| `ctx.party.getRequiredExp` | L20515 | ctx.party.getRequiredExp (party state not integrated) |
| `ctx.party.setActorLevel` | L20517 | ctx.party.setActorLevel (party state not integrated) |

## ctx.player

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.player.gatherFollowers` | L20519 | ctx.player.gatherFollowers (player runtime not bound) |
| `ctx.player.getDirection` | L20521 | No method-specific context diagnostic recovered. |
| `ctx.player.getInfo` | L20522 | No method-specific context diagnostic recovered. |
| `ctx.player.getVehicleKind` | L20523 | No method-specific context diagnostic recovered. |
| `ctx.player.jump` | L20524 | ctx.player.jump (player runtime not bound); ctx.player.jump is not allowed while riding a vehicle |
| `ctx.player.setDirection` | L20527 | ctx.player.setDirection (player runtime not bound) |
| `ctx.player.setFollowersVisible` | L20529 | ctx.player.setFollowersVisible (player runtime not bound) |
| `ctx.player.setMoveSpeed` | L20531 | ctx.player.setMoveSpeed (player runtime not bound) |
| `ctx.player.setPosition` | L20533 | ctx.player.setPosition (player runtime not bound); ctx.player.setPosition is not allowed while riding a vehicle |
| `ctx.player.setThrough` | L20536 | ctx.player.setThrough (player runtime not bound) |
| `ctx.player.setTransparent` | L20538 | ctx.player.setTransparent (player runtime not bound) |

## ctx.plugin

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.plugin.getState` | L20540 | No method-specific context diagnostic recovered. |
| `ctx.plugin.parameters` | L20541 | No method-specific context diagnostic recovered. |
| `ctx.plugin.parseValue` | L20542 | No method-specific context diagnostic recovered. |
| `ctx.plugin.setState` | L20543 | No method-specific context diagnostic recovered. |
| `ctx.plugin.typedParameters` | L20544 | No method-specific context diagnostic recovered. |

## ctx.scene

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.scene.back` | L20545 | No method-specific context diagnostic recovered. |
| `ctx.scene.current` | L20546 | No method-specific context diagnostic recovered. |
| `ctx.scene.goto` | L20547 | No method-specific context diagnostic recovered. |
| `ctx.scene.openMenu` | L20548 | No method-specific context diagnostic recovered. |
| `ctx.scene.openSaveScreen` | L20549 | No method-specific context diagnostic recovered. |
| `ctx.scene.openShop` | L20550 | No method-specific context diagnostic recovered. |

## ctx.screen

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.screen.applyBloom` | L20551 | ctx.screen.applyBloom (post-effect runtime not bound) |
| `ctx.screen.applyBlur` | L20553 | ctx.screen.applyBlur (post-effect runtime not bound) |
| `ctx.screen.applyFill` | L20555 | ctx.screen.applyFill (post-effect runtime not bound) |
| `ctx.screen.applyGlitch` | L20557 | ctx.screen.applyGlitch (post-effect runtime not bound) |
| `ctx.screen.applyPixelate` | L20559 | ctx.screen.applyPixelate (post-effect runtime not bound) |
| `ctx.screen.erasePicture` | L20561 | ctx.screen.erasePicture (picture runtime not bound) |
| `ctx.screen.fadeIn` | L20563 | ctx.screen.fadeIn (screen fader not bound) |
| `ctx.screen.fadeOut` | L20565 | ctx.screen.fadeOut (screen fader not bound) |
| `ctx.screen.flashScreen` | L20567 | ctx.screen.flashScreen (screen state runtime not bound) |
| `ctx.screen.isFading` | L20569 | No method-specific context diagnostic recovered. |
| `ctx.screen.isPictureWaiting` | L20570 | No method-specific context diagnostic recovered. |
| `ctx.screen.isPostEffectWaiting` | L20571 | No method-specific context diagnostic recovered. |
| `ctx.screen.isVideoPlaying` | L20572 | No method-specific context diagnostic recovered. |
| `ctx.screen.movePicture` | L20573 | ctx.screen.movePicture (picture runtime not bound) |
| `ctx.screen.playVideo` | L20575 | ctx.screen.playVideo (video runtime not bound) |
| `ctx.screen.removePostEffect` | L20577 | ctx.screen.removePostEffect (post-effect runtime not bound) |
| `ctx.screen.rotatePicture` | L20579 | ctx.screen.rotatePicture (picture runtime not bound) |
| `ctx.screen.scrollMap` | L20581 | ctx.screen.scrollMap (camera runtime not bound) |
| `ctx.screen.setBattlebackMap` | L20583 | ctx.screen.setBattlebackMap (screen not bound) |
| `ctx.screen.setCameraAngle` | L20585 | ctx.screen.setCameraAngle (camera runtime not bound) |
| `ctx.screen.setCameraAnglePreset` | L20587 | ctx.screen.setCameraAnglePreset (camera runtime not bound) |
| `ctx.screen.setCameraFocus` | L20589 | ctx.screen.setCameraFocus (camera runtime not bound) |
| `ctx.screen.setCameraZoom` | L20591 | ctx.screen.setCameraZoom (camera runtime not bound) |
| `ctx.screen.setPictureText` | L20593 | ctx.screen.setPictureText (picture runtime not bound) |
| `ctx.screen.setScreenEffect` | L20595 | ctx.screen.setScreenEffect (screen effect runtime not bound) |
| `ctx.screen.setWeather` | L20597 | ctx.screen.setWeather (screen state runtime not bound) |
| `ctx.screen.shakeScreen` | L20599 | ctx.screen.shakeScreen (screen state runtime not bound) |
| `ctx.screen.showPicture` | L20601 | ctx.screen.showPicture (picture runtime not bound) |
| `ctx.screen.startTimeOfDayTransition` | L20603 | ctx.screen.startTimeOfDayTransition (time-of-day runtime not bound) |
| `ctx.screen.tintPicture` | L20605 | ctx.screen.tintPicture (picture runtime not bound) |
| `ctx.screen.tintScreen` | L20607 | ctx.screen.tintScreen (screen state runtime not bound) |

## ctx.sprite

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.sprite.clear` | L20609 | No method-specific context diagnostic recovered. |
| `ctx.sprite.create` | L20610 | No method-specific context diagnostic recovered. |
| `ctx.sprite.destroy` | L20611 | No method-specific context diagnostic recovered. |
| `ctx.sprite.drawGauge` | L20612 | No method-specific context diagnostic recovered. |
| `ctx.sprite.drawText` | L20613 | No method-specific context diagnostic recovered. |
| `ctx.sprite.fillRect` | L20614 | No method-specific context diagnostic recovered. |
| `ctx.sprite.hitTest` | L20615 | No method-specific context diagnostic recovered. |
| `ctx.sprite.playSheet` | L20616 | No method-specific context diagnostic recovered. |
| `ctx.sprite.set` | L20617 | No method-specific context diagnostic recovered. |
| `ctx.sprite.setMany` | L20618 | No method-specific context diagnostic recovered. |
| `ctx.sprite.stopSheet` | L20619 | No method-specific context diagnostic recovered. |
| `ctx.sprite.tween` | L20620 | No method-specific context diagnostic recovered. |

## ctx.text

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.text.convert` | L20621 | No method-specific context diagnostic recovered. |
| `ctx.text.convertRich` | L20622 | No method-specific context diagnostic recovered. |
| `ctx.text.registerEscape` | L20623 | No method-specific context diagnostic recovered. |

## ctx.ui

| Name | Evidence | Context diagnostic, if present |
|---|---|---|
| `ctx.ui.activateList` | L20624 | No method-specific context diagnostic recovered. |
| `ctx.ui.addChoiceText` | L20625 | No method-specific context diagnostic recovered. |
| `ctx.ui.addScrollTextLine` | L20626 | No method-specific context diagnostic recovered. |
| `ctx.ui.advance` | L20627 | ctx.ui.advance (no active message) |
| `ctx.ui.appendLine` | L20629 | ctx.ui.appendLine (no active message) |
| `ctx.ui.clearWindows` | L20631 | No method-specific context diagnostic recovered. |
| `ctx.ui.closeMessage` | L20632 | No method-specific context diagnostic recovered. |
| `ctx.ui.createWindow` | L20633 | No method-specific context diagnostic recovered. |
| `ctx.ui.destroyWindow` | L20634 | No method-specific context diagnostic recovered. |
| `ctx.ui.holdForChoices` | L20635 | No method-specific context diagnostic recovered. |
| `ctx.ui.isBusy` | L20636 | No method-specific context diagnostic recovered. |
| `ctx.ui.isChoiceBusy` | L20637 | No method-specific context diagnostic recovered. |
| `ctx.ui.isItemSelectBusy` | L20638 | No method-specific context diagnostic recovered. |
| `ctx.ui.isNameInputBusy` | L20639 | No method-specific context diagnostic recovered. |
| `ctx.ui.isNumberInputBusy` | L20640 | No method-specific context diagnostic recovered. |
| `ctx.ui.isScrollTextBusy` | L20641 | No method-specific context diagnostic recovered. |
| `ctx.ui.refreshList` | L20642 | No method-specific context diagnostic recovered. |
| `ctx.ui.registerScene` | L20643 | No method-specific context diagnostic recovered. |
| `ctx.ui.sceneWindow` | L20644 | No method-specific context diagnostic recovered. |
| `ctx.ui.setListVisible` | L20645 | No method-specific context diagnostic recovered. |
| `ctx.ui.setMessageStyle` | L20646 | No method-specific context diagnostic recovered. |
| `ctx.ui.setWindow` | L20647 | No method-specific context diagnostic recovered. |
| `ctx.ui.showChoices` | L20648 | No method-specific context diagnostic recovered. |
| `ctx.ui.showItemSelect` | L20649 | No method-specific context diagnostic recovered. |
| `ctx.ui.showMessage` | L20650 | No method-specific context diagnostic recovered. |
| `ctx.ui.showNameInput` | L20651 | No method-specific context diagnostic recovered. |
| `ctx.ui.showNumberInput` | L20652 | No method-specific context diagnostic recovered. |
| `ctx.ui.showScrollText` | L20653 | No method-specific context diagnostic recovered. |
| `ctx.ui.takeChoiceResult` | L20654 | No method-specific context diagnostic recovered. |
| `ctx.ui.takeItemSelectResult` | L20655 | No method-specific context diagnostic recovered. |
| `ctx.ui.takeNameInputResult` | L20656 | No method-specific context diagnostic recovered. |
| `ctx.ui.takeNumberInputResult` | L20657 | No method-specific context diagnostic recovered. |

## Additional editor helpers

These are implemented in the embedded editor shim (L65), so they do not appear as plain `ctx.*` diagnostic literals.

- `onEditor(hookId, handler)`
- `ctx.editor.registerParamEditor(spec)`
- `ctx.editor.pick.position(opts)`
- `ctx.editor.pick.event(opts)`
- `ctx.editor.pick.region(opts)`

## Runtime hook names

Presence establishes spelling only. Filter, gate and notification contracts must be confirmed individually.

| Name | Evidence |
|---|---|
| `game.boot` | L21779 |
| `game.start` | L21783 |
| `game.update` | L21784 |
| `game.canGameOver` | L21780 |
| `game.localeChanged` | L21781 |
| `map.beforeLoad` | L23099 |
| `map.loaded` | L23101 |
| `map.canPass` | L23100 |
| `map.tileFlags` | L23106 |
| `map.regionEnter` | L23104 |
| `map.regionLeave` | L23105 |
| `event.started` | L21323 |
| `event.finished` | L21321 |
| `event.parallelTick` | L21322 |
| `event.create` | L21315 |
| `scene.beforeChange` | L24679 |
| `scene.changed` | L24680 |
| `save.before` | L24640 |
| `save.after` | L24639 |
| `load.after` | L22862 |
| `actor.param` | L19038 |
| `actor.traitObjects` | L19039 |
| `input.map` | L22348 |
| `player.moveByInput` | L24101 |
| `text.escape` | L25527 |
| `text.convert` | L25526 |
| `message.charAdvance` | L23257 |
| `picture.click` | L24063 |
| `sprite.click` | L25136 |
| `inventory.gain` | L22441 |
| `battle.actionEnd` | L19402 |
| `battle.actionStart` | L19403 |
| `battle.actorCommandStart` | L19404 |
| `battle.canUse` | L19405 |
| `battle.commandList` | L19406 |
| `battle.critRate` | L19407 |
| `battle.damage` | L19408 |
| `battle.damageValue` | L19409 |
| `battle.escape` | L19410 |
| `battle.evaRate` | L19411 |
| `battle.hitRate` | L19412 |
| `battle.result` | L19413 |
| `battle.sceneOpen` | L19414 |
| `battle.skillCost` | L19415 |
| `battle.start` | L19416 |
| `battle.startMessageHold` | L19417 |
| `battle.turnEnd` | L19418 |
| `battle.turnStart` | L19419 |
| `menu.commands` | L23240 |
| `menu.commandOk` | L23239 |

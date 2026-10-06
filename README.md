# OnePlus Camera Port

This repository contains the **OnePlus camera port** for the **OnePlus Nord 4 (`avalon`)** and **OnePlus Ace 3V (`audi`)**.

The port brings the stock OPlus camera application and its supporting framework/vendor integration into custom Android ROMs. The stack includes **OplusCamera**, **OppoGallery2**, OPlus camera framework consumers, camera processing/algo integration, required `oplus-fwk` APIs, framework changes, device-tree integration, build/Soong compatibility changes, and SELinux support.

**Userspace source:** OTA firmware from the OnePlus Nord 4 (`CPH2661_16.0.5.1001(EX01)`, OOS 11.F.16) & OnePlus Ace 3V (`PJF110_16.0.5.1001(CN01)`, COS 11.F.15), used as the source for extracting proprietary blobs and APKs for decompilation and porting.

This file maps *where* the port lives — every commit outside this repo that it depends on.

Branches get rebased or otherwise maintained over time, so if a hash 404s, match the commit by its subject line instead.

The port has bringup for both Android 16 and Android 17.

> [!IMPORTANT]
> This repository does **not** contain the proprietary camera blobs.
> Blobs are pushed separately.
> 
> **Blob repository:** [proprietary_vendor_oplus_camera](https://gitea.com/EternalMikaelson/proprietary_vendor_oplus_camera)

### Blob branches

The blob repository uses device + Android-version specific branches:

| Branch | Android | Device | Meaning |
|---|---|---|---|
| [`16-avalon`](https://gitea.com/EternalMikaelson/proprietary_vendor_oplus_camera/src/branch/16-avalon) | Android 16 | OnePlus Nord 4 | Android 16 tree branch & extracted blobs for `avalon` |
| [`16-audi`](https://gitea.com/EternalMikaelson/proprietary_vendor_oplus_camera/src/branch/16-audi) | Android 16 | OnePlus Ace 3V | Android 16 tree branch & extracted blobs for `audi` |
| [`17-avalon`](https://gitea.com/EternalMikaelson/proprietary_vendor_oplus_camera/src/branch/17-avalon) | Android 17 | OnePlus Nord 4 | Android 17 tree branch & extracted blobs for `avalon` |
| [`17-audi`](https://gitea.com/EternalMikaelson/proprietary_vendor_oplus_camera/src/branch/17-audi) | Android 17 | OnePlus Ace 3V | Android 17 tree branch & extracted blobs for `audi` |

---
> [!WARNING]
> ### Maintenance / commit hashes

Branches get rebased or otherwise maintained over time, so if a hash 404s, match the commit by its subject line instead.
This repository is actively maintained and periodically rebased on top of newer upstream or port changes.

Because rebasing rewrites commit history, **commit hashes listed in this README are not guaranteed to remain unchanged**. A hash may therefore stop resolving even though the corresponding commit and its changes are still preserved in the repository history.

When a commit hash no longer exists, **search for the commit by its subject/title instead**. The commit subject is the important part of this map; the SHA is only a snapshot of where that commit existed at the time this README was written.

The commit may still be viewed through the repository history even if its original hash has changed. This is intentional and does **not** mean that a required change has been removed.

---

### Repo map

This README maps the external repositories and commits required by the OPlus camera port. The camera repository itself is only one part of the integration; several framework, device, `hardware_oplus`, Soong, and SELinux changes are required for the complete stack.

| Repository | Role |
|---|---|
| [`proprietary_vendor_oplus_camera`](https://github.com/oplus-avalon/proprietary_vendor_oplus_camera) | Main OPlus camera port: APKs, camera configuration, framework consumers, sepolicy and integration files |
| [`android_device_oneplus_avalon`](https://github.com/oplus-avalon/android_device_oneplus_avalon) | Nord 4 device integration, camera build wiring, blob fixups and camera-specific device changes |
| [`android_device_oneplus_audi`](https://github.com/oplus-avalon/android_device_oneplus_audi) | Ace 3V device integration, camera build wiring, blob fixups and camera-specific device changes |
| [`android_device_oneplus_sm8650-common`](https://github.com/oplus-avalon/android_device_oneplus_sm8650-common) | SM8650 common camera processing/vendor library exposure |
| [`hardware_oplus`](https://github.com/oplus-avalon/hardware_oplus) | `oplus-fwk` framework/API stubs and OPlus framework compatibility required by camera/gallery |
| [`frameworks_base`](https://github.com/niklaus-labs/ax_base) | Android framework/base changes required by the OPlus camera stack |
| [`android_frameworks_native`](https://github.com/niklaus-labs/android_frameworks_native) | Native buffer, Binder and graphics-buffer compatibility for the camera stack |
| [`android_build_soong`](https://github.com/niklaus-labs/android_build_soong) | Soong/boot-jars/package compatibility for OPlus framework packages |
| [`android_frameworks_av`](https://github.com/niklaus-labs/android_frameworks_av) | CameraService, Stagefright, HDR metadata and camera buffer handling changes |
| [`android_device_qcom_sepolicy_vndr`](https://github.com/niklaus-labs/android_device_qcom_sepolicy_vndr) | Qualcomm vendor SELinux rules required by the OPlus camera stack |
| [`android_system_sepolicy`](https://github.com/niklaus-labs/android_system_sepolicy) | System SELinux changes required by the integration |

---

#### device/oneplus/avalon

The following device-tree commits are required for the Nord 4 camera integration. These cover initial camera support, `libui-stock` handling, remaining camera library dependencies, and the OPlus market-name property used by the camera stack.

| Commit | Subject |
|---|---|
| [`ebddc4f`](https://github.com/oplus-avalon/android_device_oneplus_avalon/commit/ebddc4f4b18e609e9c0f774233b2e405997794b8) | `avalon: Add support for OPlus Camera` |
| [`20fcc1a`](https://github.com/oplus-avalon/android_device_oneplus_avalon/commit/20fcc1ab35f97a33149c6f2318db0c8f7a4fc1c7) | `avalon: Patch more libui dependant cam libs to depend on libui-stock` |
| [`260a0b5`](https://github.com/oplus-avalon/android_device_oneplus_avalon/commit/260a0b507b1c453301b713d185a249fd5dafe6f7) | `avalon: Patch the remaining libs of camera stack against libui-stock` |
| [`3a6b517`](https://github.com/oplus-avalon/android_device_oneplus_avalon/commit/3a6b517c963bbf0d2ffe7876bdd60b91e437baa4) | `avalon: Add prop ro.vendor.oplus.market.(en)name for Oplus camera watermark` |

#### device/oneplus/sm8650-common

| Commit | Subject |
|---|---|
| [`760854f`](https://github.com/oplus-avalon/android_device_oneplus_sm8650-common/commit/760854f3d3c2f1f836dc63c9183aaf4cdb258bb6) | `sm8650-common: export camera processing vendor libs` |

This exposes the ArcSoft/QNN camera-processing helper libraries through the vendor public-library mechanism required by the camera application.

---

#### device/oneplus/audi

| Commit | Subject |
|---|---|
| [`c1a404b`](https://github.com/oplus-avalon/android_device_oneplus_audi/commit/c1a404b48132ad4b21280fa92fe2508f9e9cefdb) | `audi: Add support for OPlus Camera` |
| [`dc796d9`](https://github.com/oplus-avalon/android_device_oneplus_audi/commit/dc796d9083340632731b8e5c62d9eefc0c366b72) | `audi: Patch more libui dependant cam libs to depend on libui-stock` |
| [`11cf795`](https://github.com/oplus-avalon/android_device_oneplus_audi/commit/11cf795d85144d0bc761465536481a90092fc844) | `audi: Patch the remaining libs of camera stack against libui-stock` |
| [`3f2c05f`](https://github.com/oplus-avalon/android_device_oneplus_audi/commit/3f2c05f1fb786960345de03f13b6fa53c2183cd4) | `audi: Add prop ro.vendor.oplus.market.(en)name for Oplus camera watermark` |

---

#### hardware/oplus

The `hardware_oplus` changes provide the OPlus framework surface consumed by the camera/gallery stack. This includes camera-specific stubs, camera manager compatibility, HDR/HEIF support, gallery integration, and other OEM APIs required by the proprietary applications.

| Commit | Subject |
|---|---|
| [`d3c253d`](https://github.com/oplus-avalon/hardware_oplus/commit/d3c253dbf6b3e62bc7cd19bb6d16a08ce3062a0c) | `oplus-fwk: Bring in camera bits` |
| [`70a33b2`](https://github.com/oplus-avalon/hardware_oplus/commit/70a33b273e1faa3d3c88002fefe4c3101db42da4) | `oplus-fwk: Remove unused imports` |
| [`db86959`](https://github.com/oplus-avalon/hardware_oplus/commit/db8695932c07167b98386a568e8148e0cd25ccf1) | `oplus-fwk: Add missing classes for oplus camera` |
| [`848b562`](https://github.com/oplus-avalon/hardware_oplus/commit/848b56258d05f26da48badb82492d24c18d80105) | `oplus-fwk: Add more classes for OOS 16 oplus camera` |
| [`e41f776`](https://github.com/oplus-avalon/hardware_oplus/commit/e41f7765450a765c7a39770b26df495fa49c6044) | `oplus-fwk: Add OplusAudioManager stub` |
| [`5fae6c0`](https://github.com/oplus-avalon/hardware_oplus/commit/5fae6c05605e630ffe4313a53855384795875c72) | `oplus-fwk: Add more stubs for Oplus Camera new IOS-style UI update` |
| [`dfc89b0`](https://github.com/oplus-avalon/hardware_oplus/commit/dfc89b020da7b428cd26b77360d41c3a08b6686a) | `oplus-fwk: Update to latest IOplusCameraManager Cmd enum` |
| [`a70c672`](https://github.com/oplus-avalon/hardware_oplus/commit/a70c672d2be2a62f26c47d68be7565f84bd27524) | `oplus-fwk: sendOplusExtCamCmd: Don't enforce permissiom PERMISSION_SAFE_CAMERA` |
| [`9a1410a`](https://github.com/oplus-avalon/hardware_oplus/commit/9a1410afb1cd5634c7e55d6573e7a4e2941cfc50) | `oplus-fwk: Simplify getMetadataTag and metaDataValueConvert` |
| [`31096ee`](https://github.com/oplus-avalon/hardware_oplus/commit/31096eefaba9f477945ce391ae2caa66bb60bec7) | `Update shims for OP13` |
| [`024cc49`](https://github.com/oplus-avalon/hardware_oplus/commit/024cc495dc7844d75b5dd35cd633082d8c3fde2a) | `oplus-fwk: Add LinearmotorVibrator stub and shim` |
| [`4045ac1`](https://github.com/oplus-avalon/hardware_oplus/commit/4045ac1c193267edc3690b71e9a7ba228c1da15d) | `oplus-fwk: Expand com.oplus.uah stub` |
| [`d6a6ab4`](https://github.com/oplus-avalon/hardware_oplus/commit/d6a6ab416b2b438a27bf0c7e60f2129a239b018f) | `oplus-fwk: Add more classes and methods for oplus cam` |
| [`0478e99`](https://github.com/oplus-avalon/hardware_oplus/commit/0478e9941a9dea9d059505681ecdb4ecdf91cc71) | `oplus-fwk: Update feature config manager` |
| [`ca5f13b`](https://github.com/oplus-avalon/hardware_oplus/commit/ca5f13bc87c7e4d5ac913fdba21dc52aac44c6b1) | `oplus-fwk: Add missing method` |
| [`09334bb`](https://github.com/oplus-avalon/hardware_oplus/commit/09334bb018eae7a59ed16ae76835a072fc400177) | `oplus-fwk: More stubs for Oplus Camera "Liquid Glass" update` |
| [`57175c7`](https://github.com/oplus-avalon/hardware_oplus/commit/57175c777aabfc54f7be8b10c83dcbed679ce0a1) | `oplus-fwk: Add additional stub methods in OplusActivityTaskManager` |
| [`b257e08`](https://github.com/oplus-avalon/hardware_oplus/commit/b257e08951eae6b3d397452edf68aea20bf1ee28) | `oplus-fwk: restore com.oplus.media.OplusHeifWriter for motion/live photo` |
| [`ae7ab9a`](https://github.com/oplus-avalon/hardware_oplus/commit/ae7ab9a114a67ce1523df6aefde3611c6b18bd15) | `oplus-fwk: add gallery-share icon helpers + ViewWrapper (fix blank share items)` |
| [`6d264b2`](https://github.com/oplus-avalon/hardware_oplus/commit/6d264b2c49bfec21b7538b67ffab1380b2111ad3) | `oplus-fwk: Add lib oplus-fwk-vibrator-lib` |
| [`5ab026d`](https://github.com/oplus-avalon/hardware_oplus/commit/5ab026d6fbc05c7b95614d1a8a4d10fd441356d2) | `oplus-fwk: Use EFFECT_CLICK instead of EFFECT_DOUBLE_CLICK in LinearmotorVibrator` |
| [`6185859`](https://github.com/oplus-avalon/hardware_oplus/commit/618585954c45c49feb1078de685fe344953ce47d) | `oplus-fwk: Osense background-running ABI stubs` |
| [`18b51e0`](https://github.com/oplus-avalon/hardware_oplus/commit/18b51e02b4b140e9c33f7dd8018e231c9bf4481c) | `oplus-fwk: add OplusHansFreezeManager stub (fix camera crash)` |
| [`ad7d925`](https://github.com/oplus-avalon/hardware_oplus/commit/ad7d92575305f415d3de3a9b0d16fbe316f071b0) | `oplus-fwk: add Image HDR compatibility shim` |
| [`951583f`](https://github.com/oplus-avalon/hardware_oplus/commit/951583f5808c82344e4cd3f887a809fbd80e0612) | `oplus-fwk: Add media HDR and HEIF compatibility` |
| [`5b55cb8`](https://github.com/oplus-avalon/hardware_oplus/commit/5b55cb85687205fae51e7c05179591b1d6b174f9) | `oplus-fwk: Delete duplicate class` |

---

#### frameworks/base

These commits provide the Android framework APIs and compatibility hooks consumed by the OPlus camera stack.

| Commit | Subject |
|---|---|
| [`e968d11`](https://github.com/niklaus-labs/ax_base/commit/34a47987bad0b04f7ea41141d9bf4cb3b1004f83) | `AHardwareBuffer fixes for OnePlus 13 stock Camera` |
| [`da32200`](https://github.com/niklaus-labs/ax_base/commit/3ac50548555b94497c873819eef0fc93042738b9) | `ImageReader: add missing nativeGetConsumer JNI bridge for OnePlus APS` |
| [`6c67638`](https://github.com/niklaus-labs/ax_base/commit/e0667d3af61f1516ddce599f65b7d60ca366b29f) | `HardwareBuffer: free the OnePlus APS sp<GraphicBuffer> holder` |
| [`3978473`](https://github.com/niklaus-labs/ax_base/commit/a5b89ce02c5a5cd9cabf5dad1c8090d080ba592c) | `Android.bp: grant oplus-fwk visibility on framework-minus-apex-headers` |
| [`0f812b4`](https://github.com/niklaus-labs/ax_base/commit/c7d6b7146903a3ec340636cc1d934f32ddb0148f) | `Move oplus-fwk vibrator sources to device tree` |
| [`b878933`](https://github.com/niklaus-labs/ax_base/commit/f9bd1a08a8f4c90f3a597389ce2bb7352d490caa) | `Extend LinearmotorVibratorService for Oplus camera vibration` |

---

#### frameworks/native

| Commit | Subject |
|---|---|
| [`73ff5dd`](https://github.com/niklaus-labs/android_frameworks_native/commit/73ff5dd951e926fd7a1416b0afee166dab99313f) | `binder: Increase BINDER_VM_SIZE from 1MB to 4MB` |
| [`c06b7a5`](https://github.com/niklaus-labs/android_frameworks_native/commit/c06b7a50d207f3e7c22791e65e9cbe98f10f3c04) | `nativewindow: Recognize Qualcomm vendor YUV formats in formatIsYuv` |
| [`8b99617`](https://github.com/niklaus-labs/android_frameworks_native/commit/8b996175b608171bcbedb8d1550835551c7ed9c3) | `nativewindow: align Oplus camera buffer handling` |
| [`d903489`](https://github.com/niklaus-labs/android_frameworks_native/commit/d9034895b7c6d2fdffb2cb2956b4d3be4a8d776d) | `libgui: bump NUM_BUFFER_SLOTS 64->96 for Oplus camera` |
| [`2a29bb7`](https://github.com/niklaus-labs/android_frameworks_native/commit/2a29bb75a48db0dabf9e9842efd80a546a5c6e3e) | `libgui: add Oplus IGraphicBufferProducer OEM vmethods for vtable-ABI ...` |

---

#### build/soong

These Soong changes allow the OPlus framework/application packages and their bootclasspath dependencies to build correctly.

| Commit | Subject |
|---|---|
| [`4c75cfe`](https://github.com/niklaus-labs/android_build_soong/commit/4c75cfef416e94111c443d1673756d563c61dd89) | `soong: Add com.thundersoft to allowed package list` |
| [`c9c85df`](https://github.com/niklaus-labs/android_build_soong/commit/c9c85df60fd9c7c5e4777db2c3948b8fc844160c) | `bootjars: allow Oppo framework packages` |
| [`a0a0863`](https://github.com/niklaus-labs/android_build_soong/commit/a0a0863eba326a88880405f0049b6678995182b9) | `Fix OPPO Gallery share` |
| [`5033bd0`](https://github.com/niklaus-labs/android_build_soong/commit/5033bd035c9ea600df8e5e134fdf02ce51b05d4e) | `check_boot_jars: allow oplus-fwk OEM stub packages on the bootclasspath` |

---

#### frameworks/av

The `frameworks/av` changes provide CameraService and media compatibility for the proprietary OPlus camera stack, including zoom handling, OPlus metadata/HDR handling, and camera buffer behavior.

| Commit | Subject |
|---|---|
| [`08a31aa`](https://github.com/niklaus-labs/android_frameworks_av/commit/08a31aa2a35657e720c10b96cca38ad4826c48f2) | `CameraService: Add OnePlus camera extension support for zoom` |
| [`380be4e`](https://github.com/niklaus-labs/android_frameworks_av/commit/380be4e04b6967ec7239a0c8874676f6dd57e58c) | `Add some logging` |
| [`a62152a`](https://github.com/niklaus-labs/android_frameworks_av/commit/a62152a99a6ddab3fc777b81726c9f298a112524) | `Add Oplus user data member to StagefrightRecorder` |
| [`ea0ed6a`](https://github.com/niklaus-labs/android_frameworks_av/commit/ea0ed6a9ea5178ea3628e9d640f2130a23510eeb) | `Implement Oplus user data handling for HDR` |
| [`f803abd`](https://github.com/niklaus-labs/android_frameworks_av/commit/f803abdfc859c7a2d4eabfc8bc1114d015197fe4) | `Add kKeyOplusUserData to MetaDataBase.h` |
| [`eaf73b8`](https://github.com/niklaus-labs/android_frameworks_av/commit/eaf73b8ad0bdc76e00234d05796785558bc99d9e) | `HDR FIX: Enhance MPEG4Writer to handle Oplus user data with custom metadata` |
| [`630c694`](https://github.com/niklaus-labs/android_frameworks_av/commit/630c6945c9d6202996fdb96684f376c5fea75450) | `libcameraservice: Conditionally allow bypassing camera buffer error handling` |
| [`9cfcbdb`](https://github.com/niklaus-labs/android_frameworks_av/commit/9cfcbdb0b86d4401453c39fcef57563ee6a0e2f2) | `camera: Conditionally silence vendortag missing errors` |
| [`193679b`](https://github.com/niklaus-labs/android_frameworks_av/commit/193679b43af3945a62167a493ef4990e061f37fa) | `codec2: prefer semi-planar (NV12/VENUS) over YV12 for QTI encoder input` |
| [`e894e0b`](https://github.com/niklaus-labs/android_frameworks_av/commit/e894e0b97c4d4e0cb0385d522a17bb655516597e) | `Required camera/media compatibility change` |
| [`de8d059`](https://github.com/niklaus-labs/android_frameworks_av/commit/de8d059c843e2c4f93f0857c895a5626f942212d) | `Required camera/media compatibility change` |
| [`79510b2`](https://github.com/niklaus-labs/android_frameworks_av/commit/79510b25fd4c6c405087aa69ee0becd95b88e4e7) | `Required camera/media compatibility change` |
| [`e41347f`](https://github.com/niklaus-labs/android_frameworks_av/commit/e41347fecccdb8a66e2e4f306d2c3b8d66a77e17) | `Required camera/media compatibility change` |
| [`2caa987`](https://github.com/niklaus-labs/android_frameworks_av/commit/2caa9875ee3ec73abe0124a36e43f689911dc4e4) | `Required camera/media compatibility change` |
| [`967edfe`](https://github.com/niklaus-labs/android_frameworks_av/commit/967edfe9d25fac809adbe95bc5a8c734c64f6cf2) | `Required camera/media compatibility change` |

---

#### device/qcom/sepolicy_vndr/sm8650

| Commit | Subject |
|---|---|
| [`7ee334c`](https://github.com/niklaus-labs/android_device_qcom_sepolicy_vndr/commit/7ee334cd80b8e2640357b5e5115b79d8b3c77fb5) | `sepolicy: Allow OplusCamera offline camera access` |
| [`853015f`](https://github.com/niklaus-labs/android_device_qcom_sepolicy_vndr/commit/853015f9e136244c525062cc1c307f7c2bb900d6) | `sepolicy: allow Oplus camera qdsp access` |
| [`dfe9cab`](https://github.com/niklaus-labs/android_device_qcom_sepolicy_vndr/commit/dfe9cab93d727a4c86edbbda84d68ce6a3c6c8fb) | `sepolicy: allow platform apps to use qdsp device` |

These changes provide the vendor SELinux compatibility required by the OPlus camera stack.

#### system/sepolicy

| Commit | Subject |
|---|---|
| [`68350eb`](https://github.com/niklaus-labs/android_system_sepolicy/commit/68350eba34ce971000b87b000e486541119f7b36) | `Allow init and vendor_init to access proc_type` |

---

### Applying the port to `avalon` and `audi`

The common OPlus camera stack is shared between the two devices, while the device-specific integration is kept in the respective device trees.

#### Nord 4 — `avalon`

Use the `16-avalon` or `17-avalon` blob branch depending on the Android version being built, together with the `avalon` device-tree changes listed above.

#### Ace 3V — `audi`

Use the `16-audi` or `17-audi` blob branch depending on the Android version being built, together with the `audi` device-tree changes listed above.

Do not mix Android-version blob branches. In particular:

- Android 16 build → use a `16-*` blob branch.
- Android 17 build → use a `17-*` blob branch.
- Nord 4 → use `*-avalon`.
- Ace 3V → use `*-audi`.

---

### Important implementation notes

#### Framework integration

The proprietary OPlus camera application is not a standalone APK drop. It consumes OPlus framework APIs and camera-specific Android framework behavior. That is why `hardware_oplus`, `frameworks_base`, `frameworks/native`, `frameworks/av`, and `soong` changes are part of the dependency map.

#### Device-specific changes

`avalon` and `audi` share the overall camera architecture, but their extraction rules, vendor blobs, device configuration and fixups are kept separate. Always use the matching device branch and device-tree integration.

#### Device and vendor tree integration

Always sync the corresponding device and common vendor trees when reproducing this port. The camera integration depends on device-tree `extract-files.py` fixups, exported camera processing libraries, `libui-stock` handling, and device-specific camera properties. These changes are required alongside this repository and are documented in the corresponding device-tree commits.

#### Rebases

If you are reproducing this port later, **do not blindly cherry-pick the exact SHA just because it appears here**. First check whether the change already exists in your target branch or whether the upstream history has been rebased. The commit subject and actual diff are the authoritative references.

---

### Tools

- **apktool 3.0.3** — APK/jar decoding and rebuilding always `--no-res`.
- **jadx** — reading/decompiling OPlus application logic; smali is used when an actual bytecode patch is required.
- **AI assistance** — Claude Sonnet 5, Gemini & GPT-5.6 Luna.

> This README is a living document. Update the repo map and commit list when the port is rebased, dependencies change, or new required changes are introduced.

### Credits / References

- [OnePlus Camera Port](https://dodge-camera-port.vercel.app/) — credits and references to the authors behind the original OPlus Camera porting work.

### Source References

The following organizations and their repositories were used as references for this port:

- [dodge-camera-port](https://github.com/dodge-camera-port)
- [infiniti-camera-port](https://github.com/infiniti-camera-port)

Additional references are listed throughout this README where applicable.

All changes and their authorship belong to their respective original authors.

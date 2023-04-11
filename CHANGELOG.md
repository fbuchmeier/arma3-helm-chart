# Changelog

### [v0.5.6](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.5...v0.5.6) (2023-04-11)

#### Fixes

* use old status for headless client
  ([8c437dd](https://github.com/fbuchmeier/arma3-helm-chart/commit/8c437dd1139369ac47e0b9b5fc9401e9008e7e48))

### [v0.5.5](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.4...v0.5.5) (2023-04-11)

#### Features

* remove Antistasi v2.x.x installation as v3.x.x has been converted to a full mod
  ([82a2d49](https://github.com/fbuchmeier/arma3-helm-chart/commit/82a2d493853fae61682d06f8d94fa3cba8a08b8b))
* cup terrains
  ([3e8e2d9](https://github.com/fbuchmeier/arma3-helm-chart/commit/3e8e2d93b0863c38b160d3f47f3796aee1cd6d41))
* use antistasi 3.0 mod
  ([8968fc4](https://github.com/fbuchmeier/arma3-helm-chart/commit/8968fc4a8bc4a3dd219fb92967321fe9570c8047))

#### Fixes

* use correct status for headless client
  ([8cc8cc2](https://github.com/fbuchmeier/arma3-helm-chart/commit/8cc8cc21150762781dc0f8c693dd4adf3c5902b9))
* invalid yaml
  ([2c56bde](https://github.com/fbuchmeier/arma3-helm-chart/commit/2c56bdef5c8c8d363a431b213ebe8fb1a786f0c1))

### [v0.5.4](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.3...v0.5.4) (2022-11-12)

#### Fixes

* mapping key ARMA_LIMITFPS already defined at line 17
  ([a762d0f](https://github.com/fbuchmeier/arma3-helm-chart/commit/a762d0f9f697ebb1978a589542ac58eb36e8f089))

### [v0.5.3](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.2...v0.5.3) (2022-11-12)

#### Features

* added podAntiAffinity
  ([76b2e10](https://github.com/fbuchmeier/arma3-helm-chart/commit/76b2e10836008c2ec8bd48f8df6a365319ea7c21))
* added experimental grafana dashboards
  ([fca9152](https://github.com/fbuchmeier/arma3-helm-chart/commit/fca9152059807a22b88723fb6d03220d9a6db765))
* added experimental grafana dashboards
  ([7989caa](https://github.com/fbuchmeier/arma3-helm-chart/commit/7989caa937db8e5c5eff9dfb01c7965216eb1ec5))
* lower max FPS to 60 to save power
  ([b768b17](https://github.com/fbuchmeier/arma3-helm-chart/commit/b768b17243dccaaf563569f32958d2efbd073caf))
* detection of server readiness
  ([aad67f6](https://github.com/fbuchmeier/arma3-helm-chart/commit/aad67f66a1c1e7b768f25e0f644a5c6dca687784))

#### Fixes

* unicodeDecodeError
  ([b970e0b](https://github.com/fbuchmeier/arma3-helm-chart/commit/b970e0bab41a8a1ce2fc6dbf045871075a6af781))

### [v0.5.2](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.1...v0.5.2) (2022-11-05)

### [v0.5.1](https://github.com/fbuchmeier/arma3-helm-chart/compare/v0.5.0...v0.5.1) (2022-11-05)

## v0.5.0 (2022-11-05)

### Features

* add default-container, docs: updated development docs, ci: update test values
  ([f29590d](https://github.com/fbuchmeier/arma3-helm-chart/commit/f29590defdd572fa4809b9c89f9fa71c05904338))
* added tunnel for headless clients and makefile
  ([3450b16](https://github.com/fbuchmeier/arma3-helm-chart/commit/3450b16566e4bc53aa39f09a1c31e0a68b5a8ad7))
* added serviceMonitor
  ([54be643](https://github.com/fbuchmeier/arma3-helm-chart/commit/54be64331c683cd3fb41578d354f26eae049ac5a))
* released v0.3.0
  ([f011fbb](https://github.com/fbuchmeier/arma3-helm-chart/commit/f011fbb9b32524a44473f627f1197ce2649b3e3f))
* released v0.3.0
  ([125241f](https://github.com/fbuchmeier/arma3-helm-chart/commit/125241f7988aa345bf41ef6e3d04680c19d07c5d))
* run arma3 as non-root user
  ([9b7cd58](https://github.com/fbuchmeier/arma3-helm-chart/commit/9b7cd584039197440f34eda4deebf8e9df1657d9))
* run arma3 as non-root user
  ([e320218](https://github.com/fbuchmeier/arma3-helm-chart/commit/e320218fae78cedf8f14e124bdce7963d205b69b))
* initial commit
  ([85ce24e](https://github.com/fbuchmeier/arma3-helm-chart/commit/85ce24e450ca08b043044641b8aca5f1d88c43aa))

### Fixes

* increased port spacing
  ([d862ce9](https://github.com/fbuchmeier/arma3-helm-chart/commit/d862ce9a3434436967a4f86d0249f44039cac594))
* increased port spacing
  ([d4afdab](https://github.com/fbuchmeier/arma3-helm-chart/commit/d4afdab52d3e9ee08683b77415aac818f864e7e4))
* wrong tunnel svc ports
  ([1cb64c8](https://github.com/fbuchmeier/arma3-helm-chart/commit/1cb64c8a49091279dd48a714d2eff6b99d85826e))
* added missing securityContext to tunnel container
  ([e78f196](https://github.com/fbuchmeier/arma3-helm-chart/commit/e78f196d4c91893bc291c95ba5710ee2d10de3b1))
* servicemonitor
  ([fffb65b](https://github.com/fbuchmeier/arma3-helm-chart/commit/fffb65bd6aa01569328fd5e117b11296dd628ce9))
* servicemonitor
  ([88755da](https://github.com/fbuchmeier/arma3-helm-chart/commit/88755da69ebe697ed66157497ab5dd6a876b05ca))
* wrong setting for replicas
  ([a64894b](https://github.com/fbuchmeier/arma3-helm-chart/commit/a64894b5cdf988f11901c90a7bb78f7991e4a72d))
* allow running as non-root
  ([5b89d7a](https://github.com/fbuchmeier/arma3-helm-chart/commit/5b89d7afa6306c2e2dd6bc386fa554d594d9c45a))
* allow running as non-root
  ([003053b](https://github.com/fbuchmeier/arma3-helm-chart/commit/003053be3fb4eaf4595aabb0d35da8ce02dcbb93))
* allow running as non-root
  ([0e1fc24](https://github.com/fbuchmeier/arma3-helm-chart/commit/0e1fc2432cb46f2a1dcaa325b8cf5c3112e9819f))
* allow running as non-root
  ([612bdc3](https://github.com/fbuchmeier/arma3-helm-chart/commit/612bdc31a923426d22c0c638fbcae75723793aad))
* allow running as non-root
  ([4988cfe](https://github.com/fbuchmeier/arma3-helm-chart/commit/4988cfe0c723ef80c6ff695671b713b75b3fc133))
* allow running as non-root
  ([d90aca1](https://github.com/fbuchmeier/arma3-helm-chart/commit/d90aca1e660ebda4a007457504c90864a7f75e27))
* allow running as non-root
  ([387789f](https://github.com/fbuchmeier/arma3-helm-chart/commit/387789ff730078e0a4e19572cd21683cee04a1a9))
* allow running as non-root
  ([eb8a905](https://github.com/fbuchmeier/arma3-helm-chart/commit/eb8a905926a63e2771473bcd7088265216e3190e))
* allow running as non-root
  ([1d74dd0](https://github.com/fbuchmeier/arma3-helm-chart/commit/1d74dd09c3b8254fa79914ceae862793d8b5788e))
* allow running as non-root
  ([f0c49ca](https://github.com/fbuchmeier/arma3-helm-chart/commit/f0c49cac9a0ad5fcabf8d6bc9c42c7d8fd5c0293))
* allow running as non-root
  ([b550cb5](https://github.com/fbuchmeier/arma3-helm-chart/commit/b550cb574932c09a7dff0f9bdc445da522e475fb))
* tmp is not writeable
  ([b79a755](https://github.com/fbuchmeier/arma3-helm-chart/commit/b79a755a4585e4442c403532a6b450bf426ecde7))
* use curl instead of wget
  ([aab09c5](https://github.com/fbuchmeier/arma3-helm-chart/commit/aab09c518f813edbab0aea8af949813f3bd9cd11))
* allow running as non-root
  ([51b19e5](https://github.com/fbuchmeier/arma3-helm-chart/commit/51b19e5647117038ee82ea007e30d2823882f63e))

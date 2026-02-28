<template>
  <v-container class="login-page">
    <h1 class="login-title">ToDo<span class="login-title-first">Game</span></h1>
    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <h1 class="login-subtitle text-center">ToDoGameとは？</h1>
        <vue-typer
          class="login-explain"
          style="font-family: dot;"
          :text="[
            'ゲーミフィケーション　＋　やること',
            '効率的なToDoアプリです。',
            'ゲーム感覚で',
            '日々のやるべきことを',
            '終わらせよう！！！'
          ]"
          erase-style="clear"
          :type-delay="200"
          :erase-delay="200"
          :repeat="Infinity"
          caret-animation="expand"
        ></vue-typer>
        <div class="monster">
          <img class="mon" src="../assets/mon_178.gif" />
          <img class="mon" src="../assets/mon_176.gif" />
          <img class="mon" src="../assets/mon_227.gif" />
          <img class="mon" src="../assets/mon_283.gif" />
        </div>
        <div class="guest">
          <a class="btn cubic"
            ><v-btn @click="guestLogin" class="hovering">ログインする</v-btn
            ><v-btn class="default">ゲストで</v-btn></a
          >
        </div>
      </v-col>

      <v-col
        class="login-button-wrapper"
        cols="12"
        sm="12"
        md="6"
        lg="6"
      >
        <form>
          <h1 id="login-signup" class="login-form-title text-center">
            新規登録<span>は</span>こちら
          </h1>
          <v-text-field
            v-model="name"
            :counter="10"
            label="Name"
            data-vv-name="name"
            required
          ></v-text-field>
          <v-text-field
            v-model="email"
            :counter="20"
            label="Email"
            data-vv-name="email"
            required
          ></v-text-field>
          <v-text-field
            v-model="password"
            :counter="20"
            label="password"
            data-vv-name="password"
            required
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show2"
          ></v-text-field>
          <v-text-field
            v-model="passwordConfirm"
            :counter="20"
            label="passwordConfirm"
            data-vv-name="passwordConfirm"
            required
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show2"
          ></v-text-field>
          <p v-if="error" class="errors">{{ error }}</p>
        </form>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="login-button" @click="signup">
            <v-icon v-text="hover ? 'mdi-paw' : ''"></v-icon>
            はじめる
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row class="introduction" style="font-family: dot;">
      <v-col class="sub-introduction main" cols="12" sm="12" md="12" lg="12">
        <h3 class="login-explain">報酬が脳を活性化する</h3>
        <h3 class="login-explain">さらなる報酬を目指して</h3>
        <h3 class="login-explain">やるべきことをゲーム化して終わらせよう！</h3>
        <h3 class="login-explain">頑張ったあとに報酬を、、、。</h3>
      </v-col>
    </v-row>

    <div class="wrapper" style="font-family: dot;">
      <a href="#" class="button">成長したい!</a>
    </div>

    <v-row class="introduction md-0 justify-center">
      <v-col
        class="sub-introduction-1"
        mx-2
        mb-2
        cols="12"
        sm="9"
        md="3"
        lg="3"
      >
        <img src="../assets/mon_235.gif" />
        <h3 class="login-subtitle-1">
          冒険のように楽しめる
        </h3>
        <h3 class="login-explain-1">
          いつだって僕ら
        </h3>
      </v-col>

      <v-col
        class="sub-introduction-2"
        mx-2
        mb-2
        cols="12"
        sm="9"
        md="3"
        lg="3"
      >
        <img src="../assets/mon_260.gif" />
        <h3 class="login-subtitle-2">
          レベル上げを楽しもう
        </h3>
        <h3 class="login-explain-2">
          きっと誰だって
        </h3>
      </v-col>

      <v-col
        class="sub-introduction-3"
        mx-2
        mb-2
        cols="12"
        sm="9"
        md="3"
        lg="3"
      >
        <img src="../assets/mon_270.gif" />
        <h3 class="login-subtitle-3 text-center">
          それが成長へのコツ
        </h3>
        <h3 class="login-explain-3">
          楽しみたいはず。
        </h3>
      </v-col>
    </v-row>

    <div class="bottom">
      <v-btn class="bottom-btn" @click.stop="dialog = true">
        ログイン
      </v-btn>
      <v-btn class="bottom-btn" @click="moveToTop">
        新規登録
      </v-btn>
    </div>

    <v-dialog content-class="dialog" v-model="dialog" max-width="60%">
      <v-card>
        <v-card-title class="headline"><h3>ログイン</h3></v-card-title>
        <v-card-text>
          <form>
            <v-text-field
              v-model="email"
              :counter="20"
              label="email"
              data-vv-name="email"
              required
            ></v-text-field>
            <v-text-field
              v-model="password"
              label="password"
              data-vv-name="password"
              required
              :type="show1 ? 'text' : 'password'"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"
            ></v-text-field>
            <v-hover v-slot:default="{ hover }">
              <v-btn class="dialog-btn" @click="login">
                <v-icon v-text="hover ? 'mdi-paw' : ''"></v-icon>
                ログインする
              </v-btn>
            </v-hover>
            <p v-if="error" class="errors">{{ error }}</p>
          </form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from "@/plugins/axios";
import firebase from "@/plugins/firebase";
import { VueTyper } from "vue-typer";

export default {
  components: {
    "vue-typer": VueTyper
  },
  data() {
    return {
      email: "",
      name: "",
      level: "",
      experience_point: "",
      point: "",
      password: "",
      passwordConfirm: "",
      show1: false,
      show2: false,
      dialog: false,
      showContent: false,
      error: ""
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    openModal: function() {
      this.showContent = true;
    },
    closeModal: function() {
      this.showContent = false;
    },
    signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = "※パスワードとパスワード確認が一致していません";
        return;
      }
      if (this.name == "") {
        this.error = "名前を入力してください";
        return;
      }
      this.$store.commit("setLoading", false);
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          const user = {
            email: res.user.email,
            name: this.name,
            uid: res.user.uid
          };
          this.$store.commit("setLoading", true);
          axios
            .post("/v1/users", {
              user
            })
            .then(res => {
              this.$store.commit("setLoading", false);
              let param = {
                user: res.data
              };
              this.$store.commit("setUser", param);
              this.$store.commit("setNotice", {
                status: true,
                message: this.name + "さん、新規登録が完了しました！"
              });
              setTimeout(() => {
                this.$store.commit("setNotice", {});
              }, 2000);
              this.$router.push("/user");
            });
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case "auth/email-already-in-use":
                return "既にそのメールアドレスは使われています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              case "auth/weak-password":
                return "※パスワードは最低6文字以上にしてください";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    async ensureUserDocument(firebaseUser, defaultName = "") {
      try {
        const { data } = await axios.get(`/v1/users?uid=${firebaseUser.uid}`);
        if (data && data.user) {
          this.$store.commit("setUser", data);
          return;
        }
      } catch (e) {
        if (!e.response || e.response.status !== 404) {
          throw e;
        }
      }

      const { data: createdUser } = await axios.post("/v1/users", {
        user: {
          email: firebaseUser.email,
          uid: firebaseUser.uid,
          name: defaultName || "ゲスト"
        }
      });
      this.$store.commit("setUser", {
        user: createdUser,
        todos: []
      });
    },
    login() {
      firebase
        .auth()
        .signInWithEmailAndPassword(this.email, this.password)
        .then(async credential => {
          await this.ensureUserDocument(credential.user);
          this.$store.commit("setLoading", true);
          this.$store.commit("setNotice", {
            status: true,
            message: "ログインしました"
          });
          setTimeout(() => {
            this.$store.commit("setLoading", false);
          }, 1000);
          setTimeout(() => {
            this.$store.commit("setNotice", {});
          }, 2000);
          this.$router.push("/user");
        })
        .catch(error => {
          console.log(error);
          this.error = (code => {
            switch (code) {
              case "auth/user-not-found":
                return "メールアドレスが間違っています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    guestLogin() {
      this.$store.commit("setLoading", true);
      firebase
        .auth()
        .signInWithEmailAndPassword("test@gmail.com", "aaaaaa")
        .then(async credential => {
          await this.ensureUserDocument(credential.user, "ゲスト");
          this.$store.commit("setNotice", {
            status: true,
            message: "ログインしました"
          });
          setTimeout(() => {
            this.$store.commit("setLoading", false);
          }, 1000);
          setTimeout(() => {
            this.$store.commit("setNotice", {});
          }, 2000);
          this.$router.push("/user");
        })
        .catch(error => {
          console.log(error);
          this.error = (code => {
            switch (code) {
              case "auth/user-not-found":
                return "メールアドレスが間違っています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    moveToTop() {
      let element = document.getElementById("login-signup");
      element.scrollIntoView({
        behavior: "smooth",
        block: "center"
      });
      const title = document.getElementById("login-signup");
      const check = function(name) {
        title.classList.add(name);
      };
      setTimeout(check, 1000, "checked");
    },
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;
$accent-color: red;

$pc: 1024px;
$tab: 680px;
$sp: 480px;

@mixin pc {
  @media (max-width: ($pc)) {
    @content;
  }
}

@mixin tab {
  @media (max-width: ($tab)) {
    @content;
  }
}

@mixin sp {
  @media (max-width: ($sp)) {
    @content;
  }
}

@mixin explain {
  color: $main-color;
  font-family: dot;
  margin-bottom: 10px;
}

@font-face {
  font-family: dot;
  src: url("../assets/fonts/k8x12S.ttf") format("truetype");
}

.login-page {
  .mon {
    width: 20%;

    @include sp {
      width: 20%;
    }
  }
  .monster {
    text-align: center;
    margin-top: 25px;
  }

  .btn {
    position: relative;
    display: inline-block;
    transform-style: preserve-3d;
    perspective: 300px;
    width: 150px;
    height: 50px;
    margin: 0 auto;
    cursor: pointer;

    &.cubic {
      & .v-btn {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border: 1px solid $main-color;
        line-height: 48px;
        text-align: center;
        transition: all 0.3s;
        border-radius: 10%;
        font-family: dot;
        letter-spacing: 5px;
      }

      & .hovering {
        background-color: black;
        color: $sub-color;
        transform: rotateX(90deg);
        transform-origin: center center -25px;
      }

      & .default {
        background-color: black;
        color: $sub-color;
        transform: rotateX(0);
        transform-origin: center center -25px;
      }

      &:hover {
        & .hovering {
          transform: rotateX(0);
        }
        & .default {
          transform: rotateX(-90deg);
        }
      }
    }
  }

  .login-title {
    text-align: center;
    font-size: 79px;
    font-family: dot;
    letter-spacing: 15px;
    text-shadow: 3px 5px #10729c;
    margin-bottom: 0px;

    .login-title-first {
      color: $main-color;
    }
  }

  .login-subtitle,
  .login-form-title {
    @include explain;
    letter-spacing: 10px;
    span {
      display: inline-block; /* インラインブロック化 */
      transform: rotate(35deg);
      color: red;
    }
  }
  .login-explain {
    display: flex;
    justify-content: center;
    margin-top: 37px;
  }
  @mixin login-bottom-btn {
    background-color: black !important;
    border: 2px solid white;
    color: white;
    display: inline-block;
    width: 80%;
    margin: 15px;
    font-weight: bold;
  }

  .login-button-wrapper {
    .login-button {
      font-family: dot;
      font-size: 20px;
      background-color: black !important;
      border: 2px solid $main-color;
      color: $sub-color;
      width: 100%;
      &:hover {
        transform: translate(-5.5px, -5.5px);
        box-shadow: 5px 5px 0 0 rgb(5, 54, 85);
      }
    }
    .instead-of-form {
      border: 2px white solid;
      padding-top: 20px;
    }
  }

  .introduction {
    margin: 100px auto 50px;
    img {
      display: block;
      margin: 0 auto 30px;
    }
    .sub-introduction {
      text-align: center;
    }
    .main {
      border: 1px white solid;
    }
  }
  h1 {
    text-align: center;
    margin-top: 30px;
  }

  .login-button {
    &:hover {
      border: 2px solid $main-color;
      color: $sub-color;
    }
  }
  .checked {
    color: $accent-color !important;
  }
  .login-button-wrapper {
    text-align: center;
    .bottom-btn {
      @include login-bottom-btn;
      &:hover {
        border: 2px solid white;
        color: white;
      }
    }
  }
  .dialog {
    .bottom-btn {
      @include login-bottom-btn;
      &:hover {
        border: 2px solid white;
        color: white;
      }
    }
  }
  .errors {
    color: $accent-color;
  }
}

.dialog-btn {
  background-color: black;
  border: 2px solid $main-color;
  color: $main-color !important;
  display: inline-block;
  margin: 15px;
  width: 45%;
  font-weight: bold;

  &:hover {
    border: 2px solid $main-color;
    color: $sub-color;
  }
}
.headline {
  color: $sub-color;
}

.guest {
  text-align: center;
  margin-top: 40px;
  .guest-btn {
    &:hover {
      border: 2px solid $main-color;
      color: $sub-color;
    }
    @include sp {
      font-size: 25px;
      width: 80% !important;
      height: 70px !important;
    }
  }
}

$color: #2194e0;

@keyframes sheen {
  0% {
    transform: skewY(-45deg) translateX(0);
  }
  100% {
    transform: skewY(-45deg) translateX(12.5em);
  }
}

// 成長したいボタン

.wrapper {
  display: flex;
  transform: translate(-50%, -50%);
  position: absolute;
  left: 50%;
}
.button {
  padding: 0.75em 2em;
  text-align: center;
  text-decoration: none;
  color: $color;
  border: 2px solid $color;
  font-size: 24px;
  display: inline-block;
  border-radius: 0.3em;
  transition: all 0.2s ease-in-out;
  position: relative;
  overflow: hidden;
  &:before {
    content: "";
    background-color: rgba(255, 255, 255, 0.5);
    height: 100%;
    width: 3em;
    display: block;
    position: absolute;
    top: 0;
    left: -4.5em;
    transform: skewX(-45deg) translateX(0);
    transition: none;
  }
  &:hover {
    background-color: $color;
    letter-spacing: 10px;
    color: #fff;
    border-bottom: 4px solid darken($color, 10%);
    &:before {
      transform: skewX(-45deg) translateX(13.5em);
      transition: all 0.5s ease-in-out;
    }
  }
}

// ここまで

.vue-typer {
  font-size: 20px;
  letter-spacing: 10px;
}

.vue-typer .custom.char {
  color: white;
  background-color: #252424;
}
.vue-typer .custom.char.selected {
  background-color: #087df1;
}

.vue-typer .custom.caret {
  width: 10px;
  background-color: $main-color;
}

.blue {
  color: blue;
}

.login-subtitle-1 {
  color: white;
  display: flex;
  text-align: center;
  justify-content: center;
  position: relative;
}

.login-explain-1 {
  font-family: dot;
  font-size: 30px;
  color: black;
  text-align: center;
  margin: 30px 0;
  &:hover {
    transform: translate(-5.5px, -5.5px);
  }
}
.login-subtitle-2 {
  color: white;
  display: flex;
  text-align: center;
  justify-content: center;
  position: relative;
}

.login-explain-2 {
  font-family: dot;
  font-size: 30px;
  color: black;
  text-align: center;
  margin: 30px 0;
  &:hover {
    transform: translate(-5.5px, -5.5px);
  }
}
.login-subtitle-3 {
  color: white;
  display: flex;
  text-align: center;
  justify-content: center;
  position: relative;
}
.login-explain-3 {
  font-family: dot;
  font-size: 30px;
  color: black;
  text-align: center;
  margin: 30px 0;
  &:hover {
    transform: translate(-5.5px, -5.5px);
  }
}

.introduction {
  margin: 100px auto 50px;
  img {
    margin: 0 auto 30px;
    display: block;
  }

  .sub-introduction-1 {
    text-align: center;
    background-color: rgb(62, 172, 35);
    border: 3px solid skyblue;
  }

  .sub-introduction-2 {
    text-align: center;
    background-color: #aa3535;
    border: 3px solid skyblue;
  }

  .sub-introduction-3 {
    text-align: center;
    background-color: rgb(11, 214, 236);
    border: 3px solid skyblue;
  }
}

.bottom {
  text-align: center;
  .bottom-btn {
    border: 2px solid $main-color;
    color: $sub-color;
    &:hover {
      border: 2px solid #06d6a0 !important;
      color: greenyellow !important;
    }
  }
}
</style>

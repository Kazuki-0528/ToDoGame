<template>
  <v-container class="login-page">
    <h1 v-if="countHiddenPage >= 5">あなたのために祈ってます。</h1>
    <h1 class="login-title">ToDo<span class="login-title-first">Game</span></h1>
    <v-row>
      <div v-if="user"></div>
      <v-col v-else cols="12" sm="12" md="6" lg="6">
        <!-- 根拠のある言葉にしていく -->
        <h1 class="login-subtitle text-center">ToDoGameとは？</h1>
        <vue-typer
          class="login-explain"
          style="font-family: dot;"
          :text="[
            'ゲーム感覚で日々のやることをこなす',
            'ToDoアプリです。',
            'きみはもっと。もっと。カシコクナル',
            'さあ、、、イマすぐに、、、はじめよう。',
            'いくんだ。ユウシャよ、、、。'
          ]"
          erase-style="clear"
          :type-delay="200"
          :erase-delay="200"
          :repeat="Infinity"
          caret-animation="expand"
        ></vue-typer>
        <!-- <h2 class="login-explain">
          <span>ゲーム感覚</span>で日々のやることをこなす<br />
          ToDoアプリです。
        </h2> -->
        <div class="monster">
          <img class="mon" src="../assets/mon_178.gif" />
          <img class="mon" src="../assets/mon_176.gif" />
          <img class="mon" src="../assets/mon_227.gif" />
          <img class="mon" src="../assets/mon_283.gif" />
        </div>
        <div class="guest">
          <a class="btn cubic"
            ><span class="hovering">ここからはじまる</span
            ><span class="default">冒険が</span></a
          >
        </div>
        <!-- <div v-if="user"></div>
        <div class="guest" v-else>
          <v-hover v-slot:default="{ hover }">
            <v-btn class="login-button" @click="guestLogin">
              <v-icon v-text="hover ? 'mdi-feather' : ''"></v-icon
              >ゲストログイン
            </v-btn>
          </v-hover>
        </div> -->
      </v-col>

      <v-col v-if="user" class="extra-explain" cols="12" sm="12" md="12" lg="12">
        <img class="girl" src="../assets/mon_214.gif" />
        <v-icon
          id="call"
          :color="color"
          @click="countCall()"
          class="mb-5 call"
          :size="size"
          >mdi-christianity-outline</v-icon
        >
        <h1 v-if="countHiddenPage >= 10">どうか、すすんでください。</h1>
        <div class="instead-of-form">
          <vue-typer
            style="font-family: dot;"
            :text="[
              'ゆうしゃさま。 さいごまで　よんで　くださいますのね？',
              'ああ！わたしのことばを　きいてくださるかたが　いらっしゃるなんて！',
              'じゅうじかをおして　わたしのことばを',
              'きいてください、、、。',
            ]"
            erase-style="clear"
            :type-delay="140"
            :erase-delay="270"
            :repeat="Infinity"
            caret-animation="expand"
          ></vue-typer>
        </div>
      </v-col>

      <v-col
        class="login-button-wrapper"
        v-else
        cols="12"
        sm="12"
        md="6"
        lg="6"
      >
        <form>
          <h1 id="login-signup" class="login-form-title text-center">
            新規登録<span>は</span>こちら
          </h1>
          <!-- 文字を傾けたい -->
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

    <!-- <vue-typer
      style="font-family: dot;"
      :text="[
        'ここからハジマル。　ながいたび。',
        'きみはもっと。もっと。カシコクナル',
        'さあ、、、イマすぐに、、、はじめよう。',
        'いくんだ。ユウシャよ、、、'
      ]"
      erase-style="clear"
      :type-delay="230"
      :erase-delay="300"
      :repeat="Infinity"
      caret-animation="expand"
    ></vue-typer> -->
    <div v-if="user"></div>
    <v-row v-else class="introduction" style="font-family: dot;">
      <v-col class="sub-introduction main" cols="12" sm="12" md="12" lg="12">
        <h3 class="login-explain">人間は成長してこそ楽しさを感じる</h3>
        <h3 class="login-explain">さらなる高みを目指して</h3>
        <h3 class="login-explain">やるべきことをゲーム化して終わらせよう！</h3>
        <h3 class="login-explain">毎日継続</h3>
      </v-col>
    </v-row>

    <div v-if="user"></div>
    <v-row v-else class="introduction md-0 justify-center">
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
          冒険のように楽しめる<img class="item1" src="../assets/icon003.png" />
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
          レベル上げを楽しもう<img class="item2" src="../assets/icon025.png" />
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
          それが成長へのコツ<img class="item3" src="../assets/icon024.png" />
        </h3>
        <h3 class="login-explain-3">
          楽しみたいはず。
        </h3>
      </v-col>
    </v-row>

    <!-- <v-row>
      <v-col cols="12" sm="12" md="12" lg="10">
        <v-carousel height="100%">
          <v-carousel-item
            v-for="(item, i) in items"
            :key="i"
            :src="item.src"
          ></v-carousel-item>
        </v-carousel>
      </v-col>
    </v-row> -->

    <v-hover v-slot:default="{ hover }">
      <div v-if="user"></div>
      <v-btn v-else class="bottom-btn" @click.stop="dialog = true">
        <v-icon v-text="hover ? 'mdi-chess-queen' : ''"></v-icon>
        ログイン
      </v-btn>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <div v-if="user"></div>
      <v-btn v-else class="bottom-btn" @click="moveToTop">
        <v-icon v-text="hover ? 'mdi-chess-knight' : ''"></v-icon>
        新規登録
      </v-btn>
    </v-hover>
    <!-- <v-btn color="primary" dark @click.stop="dialog = true">
      open dialog
    </v-btn> -->
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
    <!-- <form>
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
      <v-btn class="mr-4" @click="login">submit</v-btn>
      <p v-if="error" class="errors">{{ error }}</p>
    </form> -->
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
      countHiddenPage: 0,
      color: "",
      size: 65,
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
    countCall() {
      this.countHiddenPage++;
      this.size += 10;
      this.color = "blue";
    }
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
  .extra-explain {
    text-align: center;
    flex-direction: column;
    .girl {
    height: 60%;
    margin-top: 40px;
    }
  }

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
      & span {
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
  .mdi-chess-queen {
    color: $main-color !important;
  }

  .mdi-chess-knight {
    color: $main-color !important;
  }

  .login-button {
    &:hover {
      border: 2px solid $main-color;
      color: $sub-color;
    }
  }
  .checked {
    color: $accent-color;
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
  .item1 {
    position: absolute;
    padding-left: 210px;
    padding-top: 3px;
  }
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
  .item2 {
    position: absolute;
    padding-left: 210px;
    padding-top: 3px;
  }
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
  .item3 {
    position: absolute;
    padding-left: 190px;
    padding-top: 3px;
  }
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
</style>

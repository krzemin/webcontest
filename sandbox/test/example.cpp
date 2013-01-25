#include<gmock/gmock.h>
#include<gtest/gtest.h>

using namespace ::testing;

class test {
  public:
    virtual int ans() = 0;
};

class mock_test : public test {
  public:
    MOCK_METHOD0(ans, int());
};



TEST(SomeTest, testTrue) {
    ASSERT_TRUE(true);
}
TEST(SomeTest, testFalse) {
    ASSERT_FALSE(false);
}

TEST(SomeOther, testX) {
    mock_test x;

    EXPECT_CALL(x, ans()).WillRepeatedly(Return(42));
    x.ans();
}


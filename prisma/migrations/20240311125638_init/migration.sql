-- CreateTable
CREATE TABLE "Company" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "website" TEXT,
    "founded" TIMESTAMP(3),
    "employees" INTEGER,
    "description" TEXT,
    "logo" TEXT,
    "logo_uuid" TEXT,
    "industry_id" INTEGER NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "phone_number" TEXT,
    "birth_date" TIMESTAMP(3),
    "gender" INTEGER NOT NULL DEFAULT 0,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "role" TEXT,
    "about_me" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Experience" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,

    CONSTRAINT "Experience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Portfolio" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT,

    CONSTRAINT "Portfolio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Languages" (
    "id" SERIAL NOT NULL,
    "language" TEXT NOT NULL,

    CONSTRAINT "Languages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserLanguages" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT,
    "language_id" INTEGER NOT NULL,

    CONSTRAINT "UserLanguages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SocialMedias" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "social_media" TEXT NOT NULL,

    CONSTRAINT "SocialMedias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSocialMedias" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "social_media_id" INTEGER NOT NULL,

    CONSTRAINT "UserSocialMedias_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Industry" (
    "id" SERIAL NOT NULL,
    "industry_name" TEXT NOT NULL,

    CONSTRAINT "Industry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TechStack" (
    "id" SERIAL NOT NULL,
    "stack_name" TEXT NOT NULL,
    "logo_path" TEXT NOT NULL,

    CONSTRAINT "TechStack_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyTechStack" (
    "id" SERIAL NOT NULL,
    "companyId" TEXT NOT NULL,
    "tech_stack_id" INTEGER NOT NULL,

    CONSTRAINT "CompanyTechStack_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Perks" (
    "id" SERIAL NOT NULL,
    "perk_name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "icon_path" TEXT NOT NULL,

    CONSTRAINT "Perks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CompanyPerks" (
    "id" SERIAL NOT NULL,
    "company_id" TEXT NOT NULL,
    "perks_id" INTEGER NOT NULL,

    CONSTRAINT "CompanyPerks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vacancy" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "max_apply_count" INTEGER NOT NULL,
    "deadline" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "job_type" TEXT NOT NULL,
    "min_salary" INTEGER,
    "max_salary" INTEGER,
    "company_id" TEXT,
    "category_id" INTEGER NOT NULL,

    CONSTRAINT "Vacancy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "category_name" TEXT NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Company" ADD CONSTRAINT "Company_industry_id_fkey" FOREIGN KEY ("industry_id") REFERENCES "Industry"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Portfolio" ADD CONSTRAINT "Portfolio_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserLanguages" ADD CONSTRAINT "UserLanguages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserLanguages" ADD CONSTRAINT "UserLanguages_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "Languages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSocialMedias" ADD CONSTRAINT "UserSocialMedias_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSocialMedias" ADD CONSTRAINT "UserSocialMedias_social_media_id_fkey" FOREIGN KEY ("social_media_id") REFERENCES "SocialMedias"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyTechStack" ADD CONSTRAINT "CompanyTechStack_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyTechStack" ADD CONSTRAINT "CompanyTechStack_tech_stack_id_fkey" FOREIGN KEY ("tech_stack_id") REFERENCES "TechStack"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyPerks" ADD CONSTRAINT "CompanyPerks_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CompanyPerks" ADD CONSTRAINT "CompanyPerks_perks_id_fkey" FOREIGN KEY ("perks_id") REFERENCES "Perks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vacancy" ADD CONSTRAINT "Vacancy_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vacancy" ADD CONSTRAINT "Vacancy_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

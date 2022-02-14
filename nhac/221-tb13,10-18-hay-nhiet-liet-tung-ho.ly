% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Nhiệt Liệt Tung Hô" }
  composer = "Tb. 13,10-18"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  c8. f16 f8 f |
  f4. e8 |
  d4 \tuplet 3/2 { bf'8 g g } |
  a4 e8 f16 (g) |
  c,8. c'16 \tuplet 3/2 { bf8 bf bf } |
  bf4 r8 bf16 g |
  a4. e8 |
  e4 \tuplet 3/2 { f8 g f } |
  d8. d16 \tuplet 3/2 { c8 e g } |
  f4. e16 f |
  d8 c4 f16 (g) |
  a4 r8 \bar "||" \break
  
  a16 f |
  f8 g g a |
  bf4 bf8 a |
  g8. g16 g8 d' ~ |
  d d b! b |
  c4 r8 g16 bf |
  a8 e f g |
  c,4 f8 e |
  f8. g16 a8 bf ~ |
  bf bf d, c |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*11
  r4.
  f16 c |
  d8 e e f |
  g4 g8 f |
  e8. e16 e8 f ~ |
  f f g g |
  e4 r8 e16 g |
  f8 c d bf |
  a4 a8 c |
  d8. e16 f8 d ~ |
  d c bf bf |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tại Giê -- ru -- sa -- lem
      mọi người hãy tuyên xưng Chúa và nói rằng:
      Hỡi Giê -- ru -- sa -- lem,
      Chúa phạt ngươi vì việc con cái ngươi làm,
      nhưng rồi lại xót thương
      vì miêu duệ người công chính.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Để nơi ngươi qua muôn thế hệ
	    Chúa sẽ làm cho kẻ lưu đầy nếm say bao hân hoan,
	    Kẻ lầm than được Ngài thương mến muôn vàn
	    cho bừng lên ánh quang
	    soi sáng cả mười phương đất.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Và dân cư muôn phương trăm họ sẽ về
	    tụng ca cùng lễ vật tiến dâng vua cao quang,
	    Đến ngàn năm, người người hoan chúc vui mừng
	    lưu truyền muôn kiếp sau
	    vì Chúa thương chọn ngươi đó.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Nào vui lên đi ngươi
	    để mừng những đoàn tử tôn người chính trực
	    đến vây chung quanh ngươi,
	    chúc tụng Chúa ngự trị muôn kiếp muôn đời,
	    ôi thực vinh phúc thay
	    cho kẻ thương phận ngươi mãi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hồn tôi ơi reo lên ca mừng Chúa Trời
	    là Vua, ngài tái tạo khắp Giê -- ru -- sa -- lem,
	    Thánh điện nay trường tồn,
	    bao cánh cửa thành cẩn toàn ngọc bích lam,
	    tường lũy xây bằng đá quý.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngọc với đá Sa -- phia trải dài khắp nẻo đường đi
	    và cửa thành trổi vang câu hoan ca,
	    Các cửa nay hợp lời:
	    Al -- le -- lu -- ia
	    ca mừng Chúa Ích -- diên,
	    nguyện hiển danh Ngài muôn kiếp.
    }
  >>
  \set stanza = "ĐK:"
  Hãy nhiệt liệt tung hô Thiên Chúa,
  Tán dương Ngài là hoàng đế thống trị ngàn thu,
  Để thánh đô được xây cất lại
  Nơi thành ngươi trong không khí nào nhiệt mừng vui.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  ragged-bottom = ##t
  page-count = 2
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

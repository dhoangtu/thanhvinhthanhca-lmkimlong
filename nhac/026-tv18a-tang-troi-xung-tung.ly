% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tầng Trời Xưng Tụng" }
  composer = "Tv. 18A"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c8 |
  c4. f8 |
  e4 g8 g |
  a2 ~ |
  a4 r8 c |
  c4. d8 |
  bf4 g8 g |
  f2 ~ |
  f8 \bar "||" \break
  
  e e \slashedGrace { e16 ( } a8) |
  d, g4 f16 (g) |
  a2 ~ |
  a8 bf bf g |
  g bf4 c8 |
  c2 ~ |
  c8 a g a |
  c4 a16 (g) d8 |
  d2 ~ |
  d8 d16 e e8 d |
  c4. g'16 e |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  c4. f8 |
  e4 c8 c |
  f2 ~ |
  f4 r8 a |
  a4. f8 |
  g4 e8 e |
  f2 ~ |
  f8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Tầng trời xưng tụng vinh quang Chúa,
  Không trung chiếu tỏ sự nghiệp Ngài.
  <<
    {
      \set stanza = "1."
      Ngày này kể lại cho ngày tới,
      Đêm nay truyền tụng cho đêm mai,
      không bằng ngôn ngữ, không bằng lời,
      nhưng tiếng đã vang cùng khắp mọi nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tầng trời Chúa trải như màn trướng,
	    Như căng lều tạm cho kim ô,
	    Di hành thanh thoát trên dặm trường
	    như dũng sĩ lên đường hớn hở vui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lề luật của Ngài ôi tuyệt tác,
	    Khiến cõi lòng mừng vui hân hoan.
	    Bao điều răn Chúa luôn vẹn toàn
	    Soi dẫn trí mê muội biết học khôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Mệnh lệnh của Ngài luôn thẳng thắn
	    Gieo hoan lạc vào tận tâm can.
	    Ôi thật minh chính quy luật Ngài
	    Đem ánh sáng soi dọi mắt phàm nhân.
    }
  >>
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
  %page-count = #1
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}

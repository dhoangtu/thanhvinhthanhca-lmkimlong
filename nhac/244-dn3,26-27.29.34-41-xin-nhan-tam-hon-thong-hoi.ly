% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Nhận Tâm Hồn Thống Hối" }
  composer = "Đn. 3,26-27.29.34-41"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 4 c8 (d) |
  g4. f16 g |
  af8 c, d g |
  f4 r8 f16 f |
  d8 d g d |
  c4. bf16 c |
  ef8 f d d |
  g4 r8 g |
  c4. c16 af |
  f4. g8 |
  c, (ef) g8 af |
  g4. ef16 ef |
  f4. g8 |
  g8. ef16 d8 g |
  c,2 \bar "||"
  
  \pageBreak
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key c \major
  e4. f8 |
  d8 d c a' |
  a4.g16 g |
  g8 a c c |
  b2 |
  d4. e16 b |
  c4. a8 |
  g4.  d16 d |
  d8 e a f |
  g4 r8 g |
  e4. f8 |
  d e c a' |
  a4. g8 |
  g g a (c) |
  b4. g8 |
  d'4. e16 b |
  c4. a8 |
  g4. d16 d |
  f8 g e d |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*14
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key c \major
  c4. d8 |
  b b c f |
  f4. f16 f |
  e8 f a a |
  g2 |
  fs4. g16 g |
  e4. f8 |
  e4. b16 b |
  b8 c c d |
  b4 r8 b |
  c4. d8 |
  b c c f |
  f4. f8 |
  e e d (a') |
  g4. g8 |
  fs4. g16 g |
  e4. f8 |
  e4. b16 b |
  d8 e c b |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa là Thiên Chúa tổ tiên chúng con,
      Xin ca ngợi và tán dương Ngài,
      Hiển vinh danh thánh Ngài ngàn kiếp.
      Vì trong mỗi sự việc Chúa làm cho chúng con
      đều tỏ ra Chúa rất công bình chính trực.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Lầm lỗi, đoàn con đã làm điều ác gian,
	    khi cam lòng tìm lánh xa Ngài,
	    thật là sai lỗi nặng nề quá,
	    Nhưng Chúa chớ bỏ mặc, chớ hủy Giao ước xưa
	    dủ tình thương nhớ tới danh cực thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tưởng nhớ tình thân với tổ phụ chúng con,
	    nay xin Ngài đừng nỡ thu hồi
	    Lòng thương yêu Chúa đã dành sẵn,
	    Ngài đã hứa sẽ làm giống dòng tăng số lên,
	    tựa trời sao, giống cát trên bờ biển dài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Lạy Chúa, vì tội lỗi mà nay chúng con
	    nên dân tộc nhỏ nhất trên đời,
	    ở mọi nơi nếm mùi nhục nhã,
	    Chẳng có cấp lãnh đạo, chẳng gặp ngôn sứ đâu,
	    người chỉ huy vắng bóng trên phần đất này.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lạy Chúa, ngày nay lễ toàn thiêu có đâu,
	    Bao sinh vật thượng tiến không còn,
	    Tàn lụi hương khói ở mọi chốn,
	    Của lễ lúc khai mùa biết đặt đâu tiến dâng,
	    để đoàn con đáng Chúa thương lại đoái nhìn.
    }
  >>
  \set stanza = "ĐK:"
  Xin Chúa nhận tâm hồn thống hối,
  và lòng thành khiêm ái chúng con thay lễ toàn thiêu chiên bò,
  và ngàn vạn cừu béo thịt ngon,
  Ước mong lễ thượng tiến Ngài hôm nay làm đẹp lòng Chúa luôn.
  Vì ai vững cậy tin nơi Ngài thì nào phải thất vọng ê chề.
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
}

TongNhip = {
  \key ef \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
